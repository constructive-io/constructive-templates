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
  ('019feb75-87d6-7c2c-a1c1-edc43a3ee14b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8695-7e24-8b0b-8db166cbaf4a', '019feb75-87d7-70dd-9516-54c0ecf94600', 'session_secrets', '019feb75-869f-77e5-b1bd-2954e3f87b89');


SET session_replication_role TO DEFAULT;


