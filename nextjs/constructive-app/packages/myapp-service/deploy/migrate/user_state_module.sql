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
  ('019feb75-8658-727f-abf4-b0c86a6c536c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'owner_id', '019feb75-8658-74d1-9931-76da2692e55d', '019feb75-8662-7462-bd4b-d8dee032dcdd', 'user_state');


SET session_replication_role TO DEFAULT;


