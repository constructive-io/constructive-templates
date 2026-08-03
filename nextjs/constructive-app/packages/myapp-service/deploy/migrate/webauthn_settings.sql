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
  ('019fbc96-ded4-7615-afc2-65534c18c4dc', '019fbc96-ae06-75fc-96c3-df2484d13ce6', '019fbc96-c1c4-7d76-8017-c296fd0375c5', '019fbc96-ae06-75fc-96c3-df2484d13ce6', '019fbc96-ae06-75fc-96c3-df2484d13ce6', '019fbc96-c578-7e37-80c4-3ba5549c2b28', '019fbc96-ae3f-7843-8d56-55dc4da7a445', '019fbc96-af80-75e3-9b05-4a449fcabc73', '019fbc96-b686-765d-895b-6bf64df652aa', NULL, '', '', '{}', 'none', false, 'required', 300, '019fbc96-84d8-7d13-8acc-4c55ad35634c');


SET session_replication_role TO DEFAULT;


