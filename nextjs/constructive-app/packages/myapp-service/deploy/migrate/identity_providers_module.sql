-- Deploy: migrate/identity_providers_module
-- made with <3 @ constructive.io

-- requires: migrate/hierarchy_module


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

INSERT INTO metaschema_modules_public.identity_providers_module (
  id,
  database_id,
  entity_field,
  schema_id,
  private_schema_id,
  public_schema_name,
  private_schema_name,
  table_id,
  table_name,
  api_name,
  private_api_name,
  scope,
  prefix,
  entity_table_id
) VALUES
  ('019fbc96-c88c-7ae8-8d8c-cb17d2052731', '019fbc96-84d8-7d13-8acc-4c55ad35634c', NULL, '019fbc96-c130-7558-9bec-78482a963cfe', '019fbc96-ae06-75fc-96c3-df2484d13ce6', NULL, NULL, '019fbc96-c88d-7ba5-bce4-cfcf39ec99a4', 'identity_providers', 'auth', NULL, 'app', 'app', NULL);


SET session_replication_role TO DEFAULT;


