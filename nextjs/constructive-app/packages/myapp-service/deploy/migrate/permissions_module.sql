-- Deploy: migrate/permissions_module
-- made with <3 @ constructive.io

-- requires: migrate/membership_types_module


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

INSERT INTO metaschema_modules_public.permissions_module (
  id,
  database_id,
  entity_field,
  schema_id,
  private_schema_id,
  public_schema_name,
  private_schema_name,
  table_id,
  table_name,
  default_table_id,
  default_table_name,
  bitlen,
  scope,
  prefix,
  entity_table_id,
  actor_table_id,
  get_padded_mask,
  get_mask,
  get_by_mask,
  get_mask_by_name,
  api_name,
  private_api_name
) VALUES
  ('019fa2a1-5105-731b-8180-e6f45b2dec9d', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', NULL, '019fa2a1-5105-75da-89c6-6d24ad9cdf16', '019fa2a1-5119-7816-ab77-973ecdcdafa4', NULL, NULL, '019fa2a1-5131-7642-b999-a3637fd3f1a5', 'app_permissions', '019fa2a1-5182-755b-a123-1190a88df2cf', 'app_permission_defaults', 64, 'app', 'app', NULL, '019fa2a1-5022-77c8-9de2-2ef6079855de', 'app_permissions_get_padded_mask', 'app_permissions_get_mask', 'app_permissions_get_by_mask', 'app_permissions_get_mask_by_names', 'admin', NULL);


SET session_replication_role TO DEFAULT;


