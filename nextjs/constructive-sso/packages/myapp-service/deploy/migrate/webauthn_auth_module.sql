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
  ('019fc105-1b3a-71a7-8d23-92a624232aa9', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fee2-7758-ae40-4fdc60702a9e', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '019fc105-0f2e-795d-b36f-44859808a931', '019fc104-ff05-737a-9287-9dc91676dc85', '019fc104-ffd2-7869-bc0e-15e9e9f99044', '019fc105-0471-784c-9f94-cb05526be1f0', '019fc105-00c9-74c6-8795-eb7e04e1c73c', '', '', '{}', 'none', false, 'required', '00:05:00');


SET session_replication_role TO DEFAULT;


