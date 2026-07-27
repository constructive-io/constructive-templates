-- Deploy: migrate/identity_providers_module
-- made with <3 @ constructive.io

-- requires: migrate/emails_module


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
  ('019fa2a1-6e02-7ed6-862e-7d9f684897f7', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', NULL, '019fa2a1-68d3-7385-938c-1973d9bed8f2', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', NULL, NULL, '019fa2a1-6e03-77a5-8d95-46056bdd7ccf', 'identity_providers', 'auth', NULL, 'app', 'app', NULL);


SET session_replication_role TO DEFAULT;


