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
  ('019fbc96-862f-73f0-9f8e-8121a7830586', '019fbc96-84d8-7d13-8acc-4c55ad35634c', NULL, '019fbc96-862f-76db-9baa-23b094401fe1', '019fbc96-8643-7a6d-8e04-033c76db6ad6', NULL, NULL, '019fbc96-865b-7f26-a4f8-32df18a9e0ae', 'app_permissions', '019fbc96-86b0-7700-97e1-d05bfdc3b002', 'app_permission_defaults', 64, 'app', 'app', NULL, '019fbc96-8533-7560-9eea-55dbc7f7fcee', 'app_permissions_get_padded_mask', 'app_permissions_get_mask', 'app_permissions_get_by_mask', 'app_permissions_get_mask_by_names', 'admin', NULL),
  ('019fbc96-93c7-74ed-a732-d389f4c5f7e9', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'entity_id', '019fbc96-862f-76db-9baa-23b094401fe1', '019fbc96-8643-7a6d-8e04-033c76db6ad6', NULL, NULL, '019fbc96-93c9-79f2-8dcb-8d72b5725eaa', 'org_permissions', '019fbc96-943e-7ea4-b55b-ac4ad60ff0e9', 'org_permission_defaults', 64, 'org', 'org', '019fbc96-8533-7560-9eea-55dbc7f7fcee', '019fbc96-8533-7560-9eea-55dbc7f7fcee', 'org_permissions_get_padded_mask', 'org_permissions_get_mask', 'org_permissions_get_by_mask', 'org_permissions_get_mask_by_names', 'admin', NULL);


SET session_replication_role TO DEFAULT;


