-- Deploy: migrate/sessions_module
-- made with <3 @ constructive.io

-- requires: migrate/session_secrets_module


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

INSERT INTO metaschema_modules_public.sessions_module (
  id,
  database_id,
  schema_id,
  sessions_table_id,
  session_credentials_table_id,
  auth_settings_table_id,
  users_table_id,
  sessions_default_expiration,
  sessions_table_name,
  session_credentials_table_name,
  auth_settings_table_name
) VALUES
  ('019fbc96-ae06-735f-9b03-82a07ef2f6f1', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ae06-75fc-96c3-df2484d13ce6', '019fbc96-ae3f-7843-8d56-55dc4da7a445', '019fbc96-af80-75e3-9b05-4a449fcabc73', '019fbc96-b0c6-757d-a948-e13949bc1c55', '019fbc96-8533-7560-9eea-55dbc7f7fcee', '30 days', 'sessions', 'session_credentials', 'app_settings_auth');


SET session_replication_role TO DEFAULT;


