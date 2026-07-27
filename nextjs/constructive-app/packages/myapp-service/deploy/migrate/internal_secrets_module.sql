-- Deploy: migrate/internal_secrets_module
-- made with <3 @ constructive.io

-- requires: migrate/identity_providers_module


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

INSERT INTO metaschema_modules_public.internal_secrets_module (
  id,
  database_id,
  schema_id,
  private_schema_id,
  public_schema_name,
  private_schema_name,
  internal_secrets_table_id,
  internal_secrets_table_name,
  api_name,
  private_api_name,
  scope,
  prefix,
  entity_table_id,
  entity_field,
  policies,
  provisions
) VALUES
  ('019fa2a1-6721-71f7-912f-09a88bff1e95', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5af9-72d1-8fba-f96774dd90ce', '019fa2a1-5af9-72d1-8fba-f96774dd90ce', NULL, NULL, '019fa2a1-674f-73fa-9633-39edfbd13c6c', 'app_internal_secrets', 'config', NULL, 'app', 'app', NULL, NULL, NULL, NULL);


SET session_replication_role TO DEFAULT;


