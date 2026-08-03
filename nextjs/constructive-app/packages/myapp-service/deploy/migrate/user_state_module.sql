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
  ('019fbc96-ad22-79b3-b6a7-1840d8f162f6', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'owner_id', '019fbc96-ad22-7c7e-a51b-2988c7c7d29f', '019fbc96-ad5b-7116-9f79-d037fdc40cd9', 'user_state');


SET session_replication_role TO DEFAULT;


