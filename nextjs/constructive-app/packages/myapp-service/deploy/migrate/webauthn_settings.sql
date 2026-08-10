-- Deploy: migrate/webauthn_settings
-- made with <3 @ constructive.io

-- requires: migrate/route_bindings


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

INSERT INTO routing_public.webauthn_settings (
  id,
  schema_id,
  credentials_schema_id,
  sessions_schema_id,
  session_secrets_schema_id,
  credentials_table_id,
  sessions_table_id,
  session_credentials_table_id,
  session_secrets_table_id,
  user_field_id,
  rp_id,
  rp_name,
  origin_allowlist,
  attestation_type,
  require_user_verification,
  resident_key,
  challenge_expiry_seconds,
  database_id
) VALUES
  ('019feb75-92b3-7651-b9ec-9c330f7501ac', '019feb75-8695-7e24-8b0b-8db166cbaf4a', '019feb75-8a0e-7a45-8898-85dfd6f8e078', '019feb75-8695-7e24-8b0b-8db166cbaf4a', '019feb75-8695-7e24-8b0b-8db166cbaf4a', '019feb75-8ad3-74a3-a82a-14d661c634a7', '019feb75-869f-77e5-b1bd-2954e3f87b89', '019feb75-86dd-7d4b-9a7a-f22c7ff73486', '019feb75-87d7-70dd-9516-54c0ecf94600', NULL, '', '', '{}', 'none', false, 'required', 300, '019feb75-7843-7bd5-a19f-88c4cbec0ee6');


SET session_replication_role TO DEFAULT;


