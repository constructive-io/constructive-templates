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
  ('019fc105-1170-73e6-9bb6-7af2a2a7a205', '019fc104-f28d-7b9c-8d9d-8f338def573c', NULL, '019fc105-0c1b-7bde-9736-c30b1029bcc9', '019fc104-fee2-7758-ae40-4fdc60702a9e', NULL, NULL, '019fc105-1171-72ca-849a-5ad7ac0b2fd3', 'identity_providers', 'auth', NULL, 'app', 'app', NULL);


SET session_replication_role TO DEFAULT;


