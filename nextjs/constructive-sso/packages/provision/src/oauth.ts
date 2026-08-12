/**
 * oauth.ts — OAuth provider + auth settings provisioning sub-step
 *
 * Runs after the main provision steps via direct superuser SQL against the
 * physical platform database. Seeds a Google-shaped identity provider pointing
 * at the local oauth2-mock-server, and configures app_settings_auth for
 * cookie-based SSO.
 *
 * This follows the same pattern as the existing services_public writes in
 * provision.ts (direct SQL, bypassing RLS via superuser + session_replication_role).
 *
 * Usage: called by provision.ts — not run standalone.
 */

import { Pool } from 'pg';

import { config } from './config.js';

/**
 * Provision the OAuth identity provider and SSO cookie settings.
 *
 * @param pgDatabase  The physical platform database name (e.g. 'constructive').
 *                    All tenant schemas live inside it (schema-based tenancy).
 */
export async function provisionOAuth(pgDatabase: string): Promise<void> {
  const dbName = config.databaseName;
  // The auth private schema for this tenant (e.g. myapp_auth_private)
  const authSchema = `${dbName}_auth_private`;

  console.log('\n  Provisioning OAuth identity provider...');

  const pool = new Pool({ database: pgDatabase });
  try {
    // -----------------------------------------------------------------------
    // Provider configuration — env-driven, mock defaults for local dev.
    //
    // Real providers: export these before running `pnpm run provision`, e.g.
    //   OAUTH_CLIENT_ID=... OAUTH_CLIENT_SECRET=... \
    //   OAUTH_AUTHORIZE_URL=https://accounts.google.com/o/oauth2/v2/auth \
    //   OAUTH_TOKEN_URL=https://oauth2.googleapis.com/token \
    //   OAUTH_USERINFO_URL=https://openidconnect.googleapis.com/v1/userinfo \
    //   pnpm run provision
    //
    // The GraphQL server reads ONLY the DB rows (identity_providers + the
    // rotated secret); these env vars exist to inject credentials at setup
    // time without hardcoding them in source.
    // -----------------------------------------------------------------------
    const oauthProvider = {
      slug: process.env.OAUTH_PROVIDER ?? 'google',
      clientId: process.env.OAUTH_CLIENT_ID ?? 'constructive-sso-local-client',
      clientSecret: process.env.OAUTH_CLIENT_SECRET ?? 'constructive-sso-local-secret',
      authorizationUrl: process.env.OAUTH_AUTHORIZE_URL ?? 'http://localhost:4010/authorize',
      tokenUrl: process.env.OAUTH_TOKEN_URL ?? 'http://localhost:4010/token',
      userinfoUrl: process.env.OAUTH_USERINFO_URL ?? 'http://localhost:4010/userinfo',
      pkceEnabled: (process.env.OAUTH_PKCE_ENABLED ?? 'true') !== 'false',
      scopes: (process.env.OAUTH_SCOPES ?? 'openid,email,profile')
        .split(',')
        .map((s) => s.trim())
        .filter(Boolean),
    };
    const isMockProvider = oauthProvider.clientId.startsWith('constructive-sso-local');
    if (isMockProvider) {
      console.log(`   Using MOCK OAuth provider (${oauthProvider.authorizationUrl}) — set OAUTH_CLIENT_ID/URLs for a real provider`);
    } else {
      console.log(`   Using REAL OAuth provider ${oauthProvider.slug} (${oauthProvider.authorizationUrl})`);
    }

    // -----------------------------------------------------------------------
    // A. Upsert identity_providers row
    //
    // The mock OAuth server (oauth2-mock-server) provides a real authorization
    // code + PKCE flow on port 4010. The identity_providers row tells the
    // CNC OAuth middleware where to redirect and where to exchange tokens.
    //
    // Uses SET LOCAL session_replication_role TO replica to bypass provider
    // management triggers (same pattern as Hub's seed-oauth.sql).
    //
    // IMPORTANT: the rotate_identity_provider_app_secret call MUST be outside
    // this replica-role transaction. The internal_secrets table has a BEFORE
    // INSERT trigger (app_internal_secrets_hash) that PGP-encrypts the value
    // using key_id as the passphrase. session_replication_role= replica disables
    // triggers, so calling rotate inside the block stores the raw secret without
    // encryption — the loader's pgp_sym_decrypt then fails with "Wrong key or
    // corrupt data" at runtime.
    // -----------------------------------------------------------------------
    await pool.query('BEGIN');
    await pool.query('SET LOCAL session_replication_role TO replica');

    const upsertResult = await pool.query(
      `INSERT INTO "${authSchema}".identity_providers (
        slug, kind, display_name, enabled,
        client_id,
        authorization_url, token_url, userinfo_url,
        scopes, pkce_enabled
      )
      VALUES (
        '${oauthProvider.slug}', 'oidc', 'Google', true,
        '${oauthProvider.clientId}',
        '${oauthProvider.authorizationUrl}',
        '${oauthProvider.tokenUrl}',
        '${oauthProvider.userinfoUrl}',
        ARRAY[${oauthProvider.scopes.map((s) => `'${s}'`).join(', ')}],
        ${oauthProvider.pkceEnabled}
      )
      ON CONFLICT (slug) DO UPDATE SET
        kind = EXCLUDED.kind,
        display_name = EXCLUDED.display_name,
        enabled = EXCLUDED.enabled,
        client_id = EXCLUDED.client_id,
        authorization_url = EXCLUDED.authorization_url,
        token_url = EXCLUDED.token_url,
        userinfo_url = EXCLUDED.userinfo_url,
        scopes = EXCLUDED.scopes,
        pkce_enabled = EXCLUDED.pkce_enabled
      RETURNING id`,
    );

    let resolvedProviderId: string | undefined = upsertResult.rows[0]?.id;
    if (!resolvedProviderId) {
      // Fallback: upsert may not RETURNING on some conflict paths
      const selectResult = await pool.query(
        `SELECT id FROM "${authSchema}".identity_providers WHERE slug = 'google' AND kind = 'oidc' LIMIT 1`,
      );
      resolvedProviderId = selectResult.rows[0]?.id;
      if (!resolvedProviderId) {
        throw new Error('Failed to upsert or find identity_providers row for google');
      }
    }

    await pool.query('COMMIT');
    console.log(`   Identity provider "google" provisioned (id: ${resolvedProviderId})`);

    // -----------------------------------------------------------------------
    // A.2. Rotate the client secret — MUST be outside the replica-role block
    //
    // The SECURITY DEFINER rotate procedure inserts into
    // app_internal_secrets with algo='pgp'. The BEFORE INSERT trigger
    // app_internal_secrets_hash PGP-encrypts the value using key_id as the
    // passphrase. The loader's SQL later decrypts with pgp_sym_decrypt using
    // the same key_id. If this runs inside session_replication_role=replica,
    // the trigger is disabled, the raw bytes are stored, and decryption fails.
    // -----------------------------------------------------------------------
    await pool.query(
      `SELECT "${authSchema}".rotate_identity_provider_app_secret($1, $2)`,
      [resolvedProviderId, oauthProvider.clientSecret],
    );
    console.log('   Client secret rotated via rotate_identity_provider_app_secret');

    // -----------------------------------------------------------------------
    // B. Update app_settings_auth for cookie-based SSO
    //
    // Local dev: cookie_domain is left empty (host-only) because a
    // Domain=localhost cookie is NOT sent by browsers to subdomains like
    // auth-myapp.localhost (the cookie spec's domain-match for the special
    // 'localhost' host is broken in Chrome/Edge/curl). A host-only cookie set
    // on auth-myapp.localhost:3000 is sent to ANY port on that host, so the
    // app is served at http://auth-myapp.localhost:3011.
    //
    // Production: set COOKIE_DOMAIN='.<real-domain>' so the session cookie
    // covers every subdomain (works on real domains), COOKIE_SECURE=true
    // (HTTPS), and OAUTH_REQUIRE_VERIFIED_EMAIL=true.
    // -----------------------------------------------------------------------
    const cookieSecure = (process.env.COOKIE_SECURE ?? 'false') === 'true';
    const cookieDomain = process.env.COOKIE_DOMAIN ?? '';
    const requireVerifiedEmail =
      (process.env.OAUTH_REQUIRE_VERIFIED_EMAIL ?? 'false') === 'true';

    await pool.query(
      `UPDATE "${authSchema}".app_settings_auth
       SET cookie_secure = ${cookieSecure},
           cookie_samesite = 'lax',
           cookie_domain = '${cookieDomain}',
           allow_identity_sign_in = true,
           allow_identity_sign_up = true,
           oauth_require_verified_email = ${requireVerifiedEmail}`,
    );
    console.log('   app_settings_auth configured for cookie-based SSO');
    console.log(`   cookie_secure=${cookieSecure}, cookie_domain=${cookieDomain || '(host-only)'}, allow_identity_sign_in=true`);
    if (requireVerifiedEmail) {
      console.log('   oauth_require_verified_email = true (verified emails only)');
    }
    console.log('   NOTE (local dev): access the app at http://auth-{db}.localhost:3011');

    // -----------------------------------------------------------------------
    // C. Grant anonymous access to identity providers for the login screen
    //
    // The auth:hardened module set does not grant anonymous access to the
    // identity_providers view. Without these grants, the login screen's
    // useIdentityProvidersQuery fails with "permission denied" — the social
    // buttons never render.
    //
    // The public view uses security_invoker=true, so PostgreSQL checks
    // permissions on the underlying private table. We need:
    //   1. GRANT SELECT on the public view to anonymous, authenticated
    //   2. GRANT SELECT (column-level) on the 4 safe columns of the private
    //      table to anonymous, authenticated (the view only exposes these)
    //   3. An RLS policy on the private table allowing anonymous/authenticated
    //      to SELECT only enabled=true rows (disabled providers are hidden)
    //
    // The private table has 24 columns including secrets (client_secret_id,
    // URLs, JWKS, etc.). Column-level grants ensure anonymous users can only
    // read slug, kind, display_name, enabled — nothing else.
    // -----------------------------------------------------------------------
    const publicSchema = `${dbName}_auth_public`;

    // 1. Grant SELECT on the public view
    await pool.query(
      `GRANT SELECT ON "${publicSchema}".identity_providers TO anonymous, authenticated`,
    );

    // 2. Column-level grant on the private table (security_invoker view)
    await pool.query(
      `GRANT SELECT (slug, kind, display_name, enabled)` +
      ` ON "${authSchema}".identity_providers TO anonymous, authenticated`,
    );

    // 3. RLS policy: anonymous/authenticated can only see enabled providers
    await pool.query(
      `DROP POLICY IF EXISTS anon_sel_enabled_providers` +
      ` ON "${authSchema}".identity_providers`,
    );
    await pool.query(
      `CREATE POLICY anon_sel_enabled_providers` +
      ` ON "${authSchema}".identity_providers` +
      ` FOR SELECT TO anonymous, authenticated` +
      ` USING (enabled = true)`,
    );

    console.log(`   Granted anonymous access to identity_providers (view + column-level + RLS policy)`);

    // -----------------------------------------------------------------------
    // D. Create identity function wrappers in the PUBLIC auth schema
    //
    // The express-context user-auth-module loader resolves the OAuth
    // identity function schema by searching pg_proc for sign_in_identity
    // with 7 args, preferring the module's PUBLIC schema name. The real
    // functions live in the _private schema, so the preference never
    // matches and alphabetical ordering picks 'constructive_auth_private'
    // (the PLATFORM schema) — whose app_settings_auth has
    // allow_identity_sign_up=false, causing IDENTITY_SIGN_UP_DISABLED.
    //
    // Creating wrappers in {db}_auth_public makes the loader resolve the
    // tenant schema. The wrappers delegate to the _private functions.
    // -----------------------------------------------------------------------
    const identityFnSql = `
      CREATE OR REPLACE FUNCTION "${publicSchema}".sign_up_identity(
        service text,
        identifier text,
        email text,
        details jsonb DEFAULT NULL::jsonb,
        credential_kind text DEFAULT 'access_token'::text,
        remember_me boolean DEFAULT false,
        device_token text DEFAULT NULL::text,
        OUT user_id uuid,
        OUT access_token text,
        OUT access_token_expires_at timestamp with time zone,
        OUT out_device_token text
      )
      RETURNS record
      LANGUAGE sql
      SECURITY DEFINER
      AS $$ SELECT * FROM "${authSchema}".sign_up_identity(
        service, identifier, email, details, credential_kind, remember_me, device_token
      ) $$;

      CREATE OR REPLACE FUNCTION "${publicSchema}".sign_in_identity(
        service text,
        identifier text,
        details jsonb DEFAULT NULL::jsonb,
        email text DEFAULT NULL::text,
        credential_kind text DEFAULT 'bearer'::text,
        remember_me boolean DEFAULT false,
        device_token text DEFAULT NULL::text,
        OUT id uuid,
        OUT user_id uuid,
        OUT access_token text,
        OUT access_token_expires_at timestamp with time zone,
        OUT is_verified boolean,
        OUT totp_enabled boolean,
        OUT mfa_required boolean,
        OUT mfa_challenge_token text,
        OUT out_device_token text,
        OUT device_approval_required boolean
      )
      RETURNS record
      LANGUAGE sql
      SECURITY DEFINER
      AS $$ SELECT * FROM "${authSchema}".sign_in_identity(
        service, identifier, details, email, credential_kind, remember_me, device_token
      ) $$;

      -- The OAuth callback runs pre-auth as the anonymous role (no token
      -- exists yet), so anonymous must have EXECUTE on these wrappers.
      -- The private functions get this via the platform's declare_anon_execute
      -- mechanism; these hand-written wrappers must grant it explicitly,
      -- otherwise the callback fails with
      -- 'permission denied for function sign_up_identity'.
      GRANT EXECUTE ON FUNCTION "${publicSchema}".sign_up_identity(
        service text, identifier text, email text, details jsonb,
        credential_kind text, remember_me boolean, device_token text
      ) TO anonymous;

      GRANT EXECUTE ON FUNCTION "${publicSchema}".sign_in_identity(
        service text, identifier text, details jsonb, email text,
        credential_kind text, remember_me boolean, device_token text
      ) TO anonymous;
    `;
    await pool.query(identityFnSql);
    console.log(`   Created sign_up_identity/sign_in_identity wrappers in ${publicSchema} (EXECUTE granted to anonymous)`);

    // -----------------------------------------------------------------------
    // E. Bare-localhost domain alias for real Google OAuth callbacks
    //
    // Google only allows plain-HTTP redirect URIs on the EXACT host
    // 'localhost' (https required for any other host). The registered Google
    // redirect URI is therefore http://localhost:3000/auth/google/callback,
    // but the CNC OAuth middleware builds the callback from the request's
    // Host header (auth-{db}.localhost). To make real-Google SSO work, the
    // whole OAuth flow must run through localhost:3000, which means the
    // routing plane must resolve 'localhost' to THIS tenant's auth API.
    //
    // This mirrors the SSO plan's 'bare-localhost alias row annotated
    // purpose=local-google-oauth-callback'.
    // -----------------------------------------------------------------------
    const authHostname = `auth-${dbName}.localhost`;

    // NOTE: each statement must be its own query — node-postgres' extended
    // query protocol (used when parameters are present) rejects multiple
    // commands in one prepared statement.
    // 1. Create the bare-localhost domain row for this tenant (if absent)
    await pool.query(
      `INSERT INTO routing_public.domains (database_id, hostname, managed)
       SELECT $1::uuid, 'localhost', false
       WHERE NOT EXISTS (
         SELECT 1 FROM routing_public.domains WHERE hostname = 'localhost'
       )`,
      [config.databaseId],
    );

    // 2. Link localhost -> this tenant's auth API, reusing the target API
    //    from the existing auth-{db}.localhost route. Only creates the
    //    route when the localhost domain actually belongs to this tenant.
    await pool.query(
      `INSERT INTO routing_public.routes (domain_id, target_api_id, database_id, path, is_active)
       SELECT d.id, r.target_api_id, $1::uuid, '/', true
       FROM routing_public.domains d
       JOIN routing_public.routes r
         ON r.database_id = $1::uuid
       JOIN routing_public.domains ad
         ON ad.id = r.domain_id AND ad.hostname = $2
       WHERE d.hostname = 'localhost'
         AND d.database_id = $1::uuid
         AND NOT EXISTS (
           SELECT 1 FROM routing_public.routes WHERE domain_id = d.id
         )`,
      [config.databaseId, authHostname],
    );
    console.log('   localhost -> auth API alias created for real Google OAuth callback');
    console.log('   NOTE: set NEXT_PUBLIC_AUTH_ENDPOINT=http://localhost:3000/graphql in .env and access the app at localhost:3011');

  } catch (err: any) {
    try { await pool.query('ROLLBACK'); } catch { /* already committed or no tx */ }
    throw new Error(`OAuth provisioning failed: ${err.message}`);
  } finally {
    await pool.end();
  }
}
