-- Deploy: migrate/session_secrets_module
-- made with <3 @ constructive.io

-- requires: migrate/rls_module


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

INSERT INTO metaschema_modules_public.session_secrets_module (
  id,
  database_id,
  schema_id,
  table_id,
  table_name,
  sessions_table_id
) VALUES
  ('019fa2a1-613b-7c85-be4d-092ccb74bb65', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', '019fa2a1-613c-724f-87a1-acb6049c0b8b', 'session_secrets', '019fa2a1-5bbc-7d2a-a42f-af8235516fb4');


SET session_replication_role TO DEFAULT;


