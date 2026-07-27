-- Deploy: migrate/webauthn_settings
-- made with <3 @ constructive.io

-- requires: migrate/view_rule


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

INSERT INTO services_public.webauthn_settings (
  id,
  database_id,
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
  challenge_expiry_seconds
) VALUES
  ('019fa2a1-7614-768f-920f-e2859410a084', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', '019fa2a1-6946-7910-96e2-15c6e11fd525', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', '019fa2a1-6bd3-7a50-b4af-3c2cb7aee426', '019fa2a1-5bbc-7d2a-a42f-af8235516fb4', '019fa2a1-5c8d-7633-a186-023c9c2285e6', '019fa2a1-613c-724f-87a1-acb6049c0b8b', NULL, '', '', '{}', 'none', false, 'required', 300);


SET session_replication_role TO DEFAULT;


