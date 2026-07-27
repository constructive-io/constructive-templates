-- Deploy: migrate/emails_module
-- made with <3 @ constructive.io

-- requires: migrate/devices_module


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

INSERT INTO metaschema_modules_public.emails_module (
  id,
  database_id,
  schema_id,
  private_schema_id,
  table_id,
  owner_table_id,
  table_name,
  api_name,
  private_api_name
) VALUES
  ('019fa2a1-6946-7700-b3db-7de253812397', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6946-7910-96e2-15c6e11fd525', '019fa2a1-6977-72e2-86f0-50e4ac24796a', '019fa2a1-69aa-7ba6-a7ef-3303f246936b', '019fa2a1-5022-77c8-9de2-2ef6079855de', 'emails', 'auth', NULL);


SET session_replication_role TO DEFAULT;


