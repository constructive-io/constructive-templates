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
  ('019fc104-fe4d-72a4-935e-b9b15523ea2d', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'owner_id', '019fc104-fe4d-756f-a748-ecfa3f8cb05b', '019fc104-fe6f-719a-8b3f-c157587194b5', 'user_state');


SET session_replication_role TO DEFAULT;


