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
  ('019fa2a1-5b92-7b60-8143-a54be41a91b8', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', '019fa2a1-5bbc-7d2a-a42f-af8235516fb4', '019fa2a1-5c8d-7633-a186-023c9c2285e6', '019fa2a1-5d87-7ece-8e60-1ad949ecfb19', '019fa2a1-5022-77c8-9de2-2ef6079855de', '30 days', 'sessions', 'session_credentials', 'app_settings_auth');


SET session_replication_role TO DEFAULT;


