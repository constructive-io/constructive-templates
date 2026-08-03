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
  ('019fbc96-beef-7024-b320-c03dcf6c211d', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ad22-7c7e-a51b-2988c7c7d29f', '019fbc96-ad22-7c7e-a51b-2988c7c7d29f', NULL, NULL, '019fbc96-bf36-74c5-8ebc-0fda254875cd', 'app_internal_secrets', 'config', NULL, 'app', 'app', NULL, NULL, NULL, NULL);


SET session_replication_role TO DEFAULT;


