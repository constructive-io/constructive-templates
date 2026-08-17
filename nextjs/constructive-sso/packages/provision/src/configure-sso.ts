/**
 * configure-sso — point the provisioned tenant's identity plane at a real
 * Google OAuth app and set the auth settings the SSO flow needs.
 *
 * Reads OAUTH_* from the environment (see .env.example), writes the provider
 * row + rotates the secret through the tenant's own procedure, and sets
 * app_settings_auth for the browser lane (host-only cookie, localhost HTTP).
 *
 * Parameterized throughout — credentials and endpoints travel as bind
 * values, never as interpolated SQL.
 */

import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

import * as dotenv from 'dotenv';
import { Client } from 'pg';

// Load the boilerplate root's .env so this works when run standalone via
// `pnpm run provision` — resolved from this module's location, not
// process.cwd() (src/ -> packages/provision/ -> packages/ -> project root).
const MODULE_DIR = dirname(fileURLToPath(import.meta.url));
dotenv.config({ path: resolve(MODULE_DIR, '../../../.env') });

const env = process.env;

const required = (name: string): string => {
  const value = env[name];
  if (!value) throw new Error(`missing ${name} in the environment`);
  return value;
};

// The physical coordinates of the provisioned tenant, resolved at runtime
// from the ticket (see provision.ts) — never guessed.
const DATABASE_ID = required('DATABASE_ID');
const PGHOST = env.PGHOST ?? 'localhost';
const PGPORT = Number(env.PGPORT ?? 15432);
const PGDATABASE = env.PGDATABASE ?? 'constructive-functions-db1';
const PGUSER = env.PGUSER ?? 'postgres';
const PGPASSWORD = env.PGPASSWORD ?? 'password';

// The tenant's identity module instance (pool-baked tenants carry the
// auth:hardened surface under a pool-* prefix; resolve it from the module
// row rather than assuming a name).
const IDENTITY_PROVIDERS_SQL = `
  SELECT s.schema_name AS private_schema_name, ipm.table_name
  FROM metaschema_modules_public.identity_providers_module ipm
  JOIN metaschema_public.schema s ON s.id = ipm.private_schema_id
  WHERE ipm.database_id = $1
  LIMIT 1
`;

// The auth settings table is resolved the way the runtime resolves it: the
// settings module's rls_settings row names the tenant's auth schema, and
// app_settings_auth lives there.
const APP_SETTINGS_AUTH_SQL = `
  SELECT s.schema_name
  FROM routing_public.rls_settings rs
  JOIN metaschema_public.schema s ON s.id = rs.authenticate_schema_id
  WHERE rs.database_id = $1
  LIMIT 1
`;

async function main(): Promise<void> {
  const client = new Client({ host: PGHOST, port: PGPORT, database: PGDATABASE, user: PGUSER, password: PGPASSWORD });
  await client.connect();

  const providerModule = await client.query(IDENTITY_PROVIDERS_SQL, [DATABASE_ID]);
  if (providerModule.rowCount === 0) {
    throw new Error(`no identity_providers_module instance for database ${DATABASE_ID} — provision the tenant first`);
  }
  const { private_schema_name: providerSchema, table_name: providersTable } = providerModule.rows[0] as {
    private_schema_name: string;
    table_name: string;
  };

  const settingsModule = await client.query(APP_SETTINGS_AUTH_SQL, [DATABASE_ID]);
  if (settingsModule.rowCount === 0) {
    throw new Error(`no rls_settings row for database ${DATABASE_ID}`);
  }
  const settingsSchema = (settingsModule.rows[0] as { schema_name: string }).schema_name;
  const settingsTable = 'app_settings_auth';

  const slug = required('OAUTH_PROVIDER');
  const clientId = required('OAUTH_CLIENT_ID');
  const clientSecret = required('OAUTH_CLIENT_SECRET');
  const authorizeUrl = required('OAUTH_AUTHORIZE_URL');
  const tokenUrl = required('OAUTH_TOKEN_URL');
  const userinfoUrl = required('OAUTH_USERINFO_URL');
  const scopes = (env.OAUTH_SCOPES ?? 'openid,email,profile').split(',');

  // Provider row: upsert by slug so re-running provision is idempotent.
  const upsertProvider = `
    INSERT INTO "${providerSchema}"."${providersTable}"
      (slug, kind, display_name, enabled, client_id, issuer_url, authorization_url,
       token_url, userinfo_url, scopes, pkce_enabled, skip_nonce_check,
       token_request_content_type, token_endpoint_auth_method, userinfo_method,
       extra_token_params)
    VALUES ($1, 'oidc', $2, true, $3, 'https://accounts.google.com', $4, $5, $6, $7, true, false,
            'form', 'client_secret_post', 'GET', '{}'::jsonb)
    ON CONFLICT (slug) DO UPDATE SET
      display_name = EXCLUDED.display_name,
      enabled = true,
      client_id = EXCLUDED.client_id,
      issuer_url = EXCLUDED.issuer_url,
      authorization_url = EXCLUDED.authorization_url,
      token_url = EXCLUDED.token_url,
      userinfo_url = EXCLUDED.userinfo_url,
      scopes = EXCLUDED.scopes,
      pkce_enabled = true,
      skip_nonce_check = false,
      token_request_content_type = EXCLUDED.token_request_content_type,
      token_endpoint_auth_method = EXCLUDED.token_endpoint_auth_method,
      userinfo_method = EXCLUDED.userinfo_method
  `;
  await client.query(upsertProvider, [slug, `Google (${slug})`, clientId, authorizeUrl, tokenUrl, userinfoUrl, scopes]);

  // Secret rotation through the tenant's own procedure: the value lands in
  // the tenant's encrypted secret store, never in this script or config.
  const provider = await client.query(
    `SELECT id FROM "${providerSchema}"."${providersTable}" WHERE slug = $1`,
    [slug]
  );
  if (provider.rowCount === 0) {
    throw new Error(`provider '${slug}' not found after upsert`);
  }
  const providerId = (provider.rows[0] as { id: string }).id;
  await client.query(
    `SELECT "${providerSchema}".rotate_identity_provider_app_secret($1, $2)`,
    [providerId, clientSecret]
  );

  // Auth settings for the browser lane: host-only cookie (no Domain — the
  // app and the gateway share the `localhost` host across ports), plain HTTP
  // only in this local environment, errors land on the app's login page.
  const upsertSettings = `
    UPDATE "${settingsSchema}"."${settingsTable}" SET
      allow_identity_sign_in = true,
      allow_identity_sign_up = true,
      oauth_require_verified_email = true,
      oauth_error_redirect_path = '/login',
      cookie_domain = NULL,
      cookie_secure = false,
      cookie_samesite = 'lax'
  `;
  await client.query(upsertSettings);

  // The sign-in lane runs as the `anonymous` role (the sync gateway's default
  // for a request without a credential). Pool-baked tenants carry no anonymous
  // grants, so the lane would fail at the first procedure call — grant the
  // auth surface the way the sink seed does.
  //
  // A DO block cannot take bind parameters, so the (trusted, DB-derived)
  // schema prefix is interpolated directly — single quotes escaped defensively.
  const prefix = providerSchema.split('-').slice(0, 3).join('-');
  const esc = (s: string): string => s.replace(/'/g, "''");
  const likeAll = esc(`${prefix}-%`);
  const likeExclude = esc(`${prefix}-app-private%`);
  await client.query(`
    DO $$
    DECLARE
      r record;
    BEGIN
      FOR r IN
        SELECT n.nspname AS s, p.proname AS f, pg_get_function_identity_arguments(p.oid) AS args
        FROM pg_proc p JOIN pg_namespace n ON n.oid = p.pronamespace
        WHERE n.nspname LIKE '${likeAll}'
          AND n.nspname NOT LIKE '${likeExclude}'
      LOOP
        EXECUTE format('GRANT EXECUTE ON FUNCTION %I.%I(%s) TO anonymous', r.s, r.f, r.args);
      END LOOP;
      FOR r IN
        SELECT schemaname AS s, tablename AS t FROM pg_tables WHERE schemaname LIKE '${likeAll}'
      LOOP
        EXECUTE format('GRANT SELECT, INSERT, UPDATE, DELETE ON %I.%I TO anonymous', r.s, r.t);
      END LOOP;
    END $$;
  `);

  console.log(`SSO provider '${slug}' configured on tenant ${DATABASE_ID} (${providerSchema})`);
  console.log('  secret rotated via rotate_identity_provider_app_secret');

  await client.end();
}

main().catch((err: unknown) => {
  console.error(err instanceof Error ? err.message : String(err));
  process.exit(1);
});
