-- Deploy: migrate/user_credentials_module
-- made with <3 @ constructive.io

-- requires: migrate/user_auth_module


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

INSERT INTO metaschema_modules_public.user_credentials_module (
  id,
  database_id,
  entity_field,
  schema_id,
  table_id,
  table_name,
  private_api_name
) VALUES
  ('019fc105-0996-7765-bbb5-9b6253adbb21', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'owner_id', '019fc104-fe4d-756f-a748-ecfa3f8cb05b', '019fc105-0996-7bb7-8ecb-595462857b72', 'user_secrets', NULL);


SET session_replication_role TO DEFAULT;


