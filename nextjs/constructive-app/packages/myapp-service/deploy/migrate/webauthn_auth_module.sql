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
  ('019fbc96-de88-7899-a088-9c12460ca002', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ae06-75fc-96c3-df2484d13ce6', '019fbc96-8533-7560-9eea-55dbc7f7fcee', '019fbc96-c578-7e37-80c4-3ba5549c2b28', '019fbc96-ae3f-7843-8d56-55dc4da7a445', '019fbc96-af80-75e3-9b05-4a449fcabc73', '019fbc96-b686-765d-895b-6bf64df652aa', '019fbc96-b0c6-757d-a948-e13949bc1c55', '', '', '{}', 'none', false, 'required', '00:05:00');


SET session_replication_role TO DEFAULT;


