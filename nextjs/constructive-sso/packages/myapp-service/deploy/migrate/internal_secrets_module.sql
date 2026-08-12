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
  ('019fc105-0a5c-726f-b653-c444fd3b2a7a', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fe4d-756f-a748-ecfa3f8cb05b', '019fc104-fe4d-756f-a748-ecfa3f8cb05b', NULL, NULL, '019fc105-0a8c-74f6-873c-134a7419f69c', 'app_internal_secrets', 'config', NULL, 'app', 'app', NULL, NULL, NULL, NULL);


SET session_replication_role TO DEFAULT;


