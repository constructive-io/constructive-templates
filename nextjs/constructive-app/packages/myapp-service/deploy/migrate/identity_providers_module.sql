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
  ('019feb75-8b7d-7c7d-a8a5-de7c495348e9', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', NULL, '019feb75-89de-7d6c-a0e8-f04fbeb7d8d9', '019feb75-8695-7e24-8b0b-8db166cbaf4a', NULL, NULL, '019feb75-8b7e-7a85-9b53-09c3e40fc17e', 'identity_providers', 'auth', NULL, 'app', 'app', NULL);


SET session_replication_role TO DEFAULT;


