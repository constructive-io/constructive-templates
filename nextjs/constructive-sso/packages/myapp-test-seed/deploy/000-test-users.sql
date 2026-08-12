-- Deploy myapp-test-seed:000-test-users to pg
-- Seed: test users for local development (auth:hardened — no org surface)
-- Mirrors provision/src/seed/index.ts in pure SQL so pgpm deploy can run it

-- ============================================================
-- 0. Create default partitions for RANGE-partitioned tables
-- pg_partman may not have run in local dev, so INSERTs into
-- partitioned tables fail with "no partition of relation found
-- for row". A DEFAULT partition catches any row that doesn't
-- match an existing range partition.
--
-- Only the two partitioned tables in the auth:hardened tenant
-- (audit_log_auth, app_limit_events) are handled here.
-- ============================================================

DO $$
BEGIN
  -- audit_log_auth
  IF NOT EXISTS (
    SELECT 1 FROM pg_inherits i JOIN pg_class c ON i.inhrelid = c.oid
    JOIN pg_namespace n ON c.relnamespace = n.oid
    WHERE i.inhparent = 'myapp_logging_public.audit_log_auth'::regclass
    AND c.relname = 'audit_log_auth_default'
  ) THEN
    EXECUTE 'CREATE TABLE myapp_logging_public.audit_log_auth_default PARTITION OF myapp_logging_public.audit_log_auth DEFAULT';
  END IF;

  -- app_limit_events
  IF NOT EXISTS (
    SELECT 1 FROM pg_inherits i JOIN pg_class c ON i.inhrelid = c.oid
    JOIN pg_namespace n ON c.relnamespace = n.oid
    WHERE i.inhparent = 'myapp_limits_public.app_limit_events'::regclass
    AND c.relname = 'app_limit_events_default'
  ) THEN
    EXECUTE 'CREATE TABLE myapp_limits_public.app_limit_events_default PARTITION OF myapp_limits_public.app_limit_events DEFAULT';
  END IF;
END;
$$;

-- ============================================================
-- 1. Fix app_membership_defaults so non-owner users get approved
-- ============================================================
UPDATE "myapp_memberships_public".app_membership_defaults
SET is_approved = TRUE, is_verified = TRUE;

-- ============================================================
-- 1b. Add DELETE RLS policy so users can delete their own row
-- (the app's deleteUser mutation is a direct table delete)
-- ============================================================
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'myapp_users_public' AND tablename = 'users' AND policyname = 'auth_del_own'
  ) THEN
    CREATE POLICY auth_del_own ON "myapp_users_public".users
      FOR DELETE TO authenticated
      USING (id = jwt_public.current_user_id());
  END IF;
END;
$$;

-- ============================================================
-- 2. Helper function to create a user with email, password, app membership
-- ============================================================

CREATE OR REPLACE FUNCTION pg_temp.seed_user(
  p_id uuid,
  p_username text,
  p_display_name text,
  p_email text,
  p_is_owner boolean DEFAULT FALSE,
  p_is_admin boolean DEFAULT FALSE
) RETURNS void AS $$
BEGIN
  INSERT INTO "myapp_users_public".users (id, username, display_name)
  VALUES (p_id, p_username, p_display_name)
  ON CONFLICT (id) DO UPDATE SET display_name = EXCLUDED.display_name, username = EXCLUDED.username;

  INSERT INTO "myapp_user_identifiers_public".emails (owner_id, email)
  VALUES (p_id, p_email)
  ON CONFLICT DO NOTHING;

  PERFORM "myapp_store_private".user_secrets_set(p_id, 'password_hash', 'Password123!', 'crypt');

  INSERT INTO "myapp_memberships_public".app_memberships (
    actor_id, is_owner, is_admin, is_approved, is_verified, is_active,
    is_banned, is_disabled, capabilities
  ) VALUES (
    p_id, p_is_owner, p_is_admin, TRUE, TRUE, TRUE,
    FALSE, FALSE, '0000000000000000000000000000000000000000000000000000000000000001'::bit(64)
  ) ON CONFLICT (actor_id) DO UPDATE SET
    is_owner = EXCLUDED.is_owner, is_admin = EXCLUDED.is_admin,
    is_approved = EXCLUDED.is_approved, is_verified = EXCLUDED.is_verified,
    is_active = EXCLUDED.is_active, is_banned = EXCLUDED.is_banned,
    is_disabled = EXCLUDED.is_disabled, capabilities = EXCLUDED.capabilities;
END;
$$ LANGUAGE plpgsql;

-- ============================================================
-- 3. Admin user (platform super-admin)
-- ============================================================

SELECT pg_temp.seed_user('00000000-0000-0000-0000-00000000ad01'::uuid, 'myapp.admin', 'MyApp Admin', 'admin@myapp.local', TRUE, TRUE);

-- ============================================================
-- 4. Test user: Alice Chen
-- ============================================================

SELECT pg_temp.seed_user('00000000-0000-0000-0000-000000000001'::uuid, 'alice.chen', 'Alice Chen', 'alice@example.com', FALSE, FALSE);

-- ============================================================
-- 5. Test user: Bob Martinez
-- ============================================================

SELECT pg_temp.seed_user('00000000-0000-0000-0000-000000000002'::uuid, 'bob.martinez', 'Bob Martinez', 'bob@example.com', FALSE, FALSE);
