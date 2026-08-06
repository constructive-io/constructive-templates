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
        'google', 'oidc', 'Google', true,
        'constructive-sso-local-client',
        'http://localhost:4010/authorize',
        'http://localhost:4010/token',
        'http://localhost:4010/userinfo',
        ARRAY['openid', 'email', 'profile'],
        true
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
      [resolvedProviderId, 'constructive-sso-local-secret'],
    );
    console.log('   Client secret rotated via rotate_identity_provider_app_secret');

    // -----------------------------------------------------------------------
    // B. Update app_settings_auth for cookie-based SSO
    //
    // cookie_domain is LEFT EMPTY (host-only cookie) — this is critical.
    // A Domain=localhost cookie is NOT sent by browsers (or curl) to
    // subdomains like auth-myapp.localhost: the cookie spec's domain-match
    // for the special 'localhost' host is broken in Chrome/Edge/curl.
    // With a host-only cookie, the cookie set on auth-myapp.localhost:3000
    // is sent to ANY port on auth-myapp.localhost — so the Next.js app must
    // be accessed at http://auth-myapp.localhost:3011 (not localhost:3011)
    // for the session to hydrate.
    // -----------------------------------------------------------------------
    await pool.query(
      `UPDATE "${authSchema}".app_settings_auth
       SET cookie_secure = false,
           cookie_samesite = 'lax',
           cookie_domain = '',
           allow_identity_sign_in = true,
           allow_identity_sign_up = true,
           oauth_require_verified_email = false`,
    );
    console.log('   app_settings_auth configured for cookie-based SSO');
    console.log('   cookie_domain= (host-only), cookie_secure=false, allow_identity_sign_in=true');
    console.log('   NOTE: access the app at http://auth-{db}.localhost:3011 (NOT localhost:3011)');

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

  } catch (err: any) {
    try { await pool.query('ROLLBACK'); } catch { /* already committed or no tx */ }
    throw new Error(`OAuth provisioning failed: ${err.message}`);
  } finally {
    await pool.end();
  }
}
