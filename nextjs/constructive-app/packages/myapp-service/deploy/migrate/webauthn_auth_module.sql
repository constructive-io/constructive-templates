-- Deploy: migrate/webauthn_auth_module
-- made with <3 @ constructive.io

-- requires: migrate/users_module


SET session_replication_role TO replica;
-- using replica in case we are deploying triggers to metaschema_public

-- unaccent, postgis affected and require grants
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public to public;

DO $LQLMIGRATION$
  DECLARE
  BEGIN

    EXECUTE format('GRANT CONNECT ON DATABASE %I TO %I', current_database(), 'app_user');
    EXECUTE format('GRANT CONNECT ON DATABASE %I TO %I', current_database(), 'app_admin');

  END;
$LQLMIGRATION$;

INSERT INTO metaschema_modules_public.webauthn_auth_module (
  id,
  database_id,
  schema_id,
  users_table_id,
  credentials_table_id,
  sessions_table_id,
  session_credentials_table_id,
  session_secrets_table_id,
  auth_settings_table_id,
  rp_id,
  rp_name,
  origin_allowlist,
  attestation_type,
  require_user_verification,
  resident_key,
  challenge_expiry
) VALUES
  ('019feb75-9259-76ae-a42a-536592aadfaf', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8695-7e24-8b0b-8db166cbaf4a', '019feb75-78e2-720e-82dc-c3ed84264ce8', '019feb75-8ad3-74a3-a82a-14d661c634a7', '019feb75-869f-77e5-b1bd-2954e3f87b89', '019feb75-86dd-7d4b-9a7a-f22c7ff73486', '019feb75-87d7-70dd-9516-54c0ecf94600', '019feb75-8713-7ceb-a1b7-6f4fffe21b51', '', '', '{}', 'none', false, 'required', '00:05:00');


SET session_replication_role TO DEFAULT;


