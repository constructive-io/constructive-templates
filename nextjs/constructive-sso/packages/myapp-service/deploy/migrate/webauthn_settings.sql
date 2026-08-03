-- Deploy: migrate/webauthn_settings
-- made with <3 @ constructive.io

-- requires: migrate/sites


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
  ('019fc105-1b7c-7beb-8ec1-f2acc84dcb26', '019fc104-fee2-7758-ae40-4fdc60702a9e', '019fc105-0c8d-72ee-983e-7d7c1610c7f5', '019fc104-fee2-7758-ae40-4fdc60702a9e', '019fc104-fee2-7758-ae40-4fdc60702a9e', '019fc105-0f2e-795d-b36f-44859808a931', '019fc104-ff05-737a-9287-9dc91676dc85', '019fc104-ffd2-7869-bc0e-15e9e9f99044', '019fc105-0471-784c-9f94-cb05526be1f0', NULL, '', '', '{}', 'none', false, 'required', 300, '019fc104-f28d-7b9c-8d9d-8f338def573c');


SET session_replication_role TO DEFAULT;


