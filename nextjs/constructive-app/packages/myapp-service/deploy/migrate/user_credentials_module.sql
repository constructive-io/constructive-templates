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
  ('019feb75-891b-7774-bb09-be001384f4c3', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'owner_id', '019feb75-8658-74d1-9931-76da2692e55d', '019feb75-891b-7bcd-9ed3-1fc29a40c6cd', 'user_secrets', NULL);


SET session_replication_role TO DEFAULT;


