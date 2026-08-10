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
  ('019feb75-8695-7bd6-bbf3-28a4ba7f8b93', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8695-7e24-8b0b-8db166cbaf4a', '019feb75-869f-77e5-b1bd-2954e3f87b89', '019feb75-86dd-7d4b-9a7a-f22c7ff73486', '019feb75-8713-7ceb-a1b7-6f4fffe21b51', '019feb75-78e2-720e-82dc-c3ed84264ce8', '30 days', 'sessions', 'session_credentials', 'app_settings_auth');


SET session_replication_role TO DEFAULT;


