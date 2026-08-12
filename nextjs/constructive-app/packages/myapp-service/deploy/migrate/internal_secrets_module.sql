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
  ('019feb75-895a-7df5-befb-04b92cbe59df', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8658-74d1-9931-76da2692e55d', '019feb75-8658-74d1-9931-76da2692e55d', NULL, NULL, '019feb75-8966-7ecd-bc75-e2778b51a789', 'app_internal_secrets', 'config', NULL, 'app', 'app', NULL, NULL, NULL, NULL);


SET session_replication_role TO DEFAULT;


