-- Deploy: migrate/user_state_module
-- made with <3 @ constructive.io

-- requires: migrate/user_credentials_module


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

INSERT INTO metaschema_modules_public.user_state_module (
  id,
  database_id,
  entity_field,
  schema_id,
  table_id,
  table_name
) VALUES
  ('019fa2a1-5af9-7021-8cd0-972264f2604f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'owner_id', '019fa2a1-5af9-72d1-8fba-f96774dd90ce', '019fa2a1-5b1d-7b27-bab2-e3c469e536af', 'user_state');


SET session_replication_role TO DEFAULT;


