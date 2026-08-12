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
  ('019fc104-f3fa-7eb7-b94e-bcfe626cc4b9', '019fc104-f28d-7b9c-8d9d-8f338def573c', NULL, '019fc104-f3fb-7199-84be-973cb5027963', '019fc104-f410-7e31-8f42-b46383f39596', NULL, NULL, '019fc104-f42b-7451-ad34-360101e6f0bb', 'app_permissions', '019fc104-f485-7df6-ba4b-f9ea1f7a605a', 'app_permission_defaults', 64, 'app', 'app', NULL, '019fc104-f2f4-73b2-abcd-47aa47fa7997', 'app_permissions_get_padded_mask', 'app_permissions_get_mask', 'app_permissions_get_by_mask', 'app_permissions_get_mask_by_names', 'admin', NULL);


SET session_replication_role TO DEFAULT;


