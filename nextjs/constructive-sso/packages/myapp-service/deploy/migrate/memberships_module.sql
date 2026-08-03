-- Deploy: migrate/memberships_module
-- made with <3 @ constructive.io

-- requires: migrate/view_rule


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

INSERT INTO metaschema_modules_public.memberships_module (
  id,
  database_id,
  entity_field,
  schema_id,
  private_schema_id,
  public_schema_name,
  private_schema_name,
  memberships_table_id,
  memberships_table_name,
  members_table_id,
  members_table_name,
  membership_defaults_table_id,
  membership_defaults_table_name,
  membership_settings_table_id,
  membership_settings_table_name,
  grants_table_id,
  grants_table_name,
  actor_table_id,
  limits_table_id,
  default_limits_table_id,
  permissions_table_id,
  default_permissions_table_id,
  sprt_table_id,
  admin_grants_table_id,
  admin_grants_table_name,
  owner_grants_table_id,
  owner_grants_table_name,
  scope,
  prefix,
  entity_table_id,
  entity_table_owner_id,
  get_org_fn,
  actor_mask_check,
  actor_perm_check,
  entity_ids_by_mask,
  entity_ids_by_perm,
  entity_ids_function,
  member_profiles_table_id,
  permission_default_permissions_table_id,
  permission_default_grants_table_id,
  api_name,
  private_api_name
) VALUES
  ('019fc104-f8a8-701e-a270-4b7a93906e6e', '019fc104-f28d-7b9c-8d9d-8f338def573c', NULL, '019fc104-f39c-7300-895c-30b0b61a670e', '019fc104-f8a8-7507-a922-39132d5dfbe9', NULL, NULL, '019fc104-f8d1-7179-8d86-1ce7702d0104', 'app_memberships', '019fc104-f2f4-73b2-abcd-47aa47fa7997', 'app_members', '019fc104-f919-7c68-b65c-ead0b86f3cc4', 'app_membership_defaults', NULL, 'app_membership_settings', '019fc104-fb03-7075-b98c-fc2016e45ebb', 'app_grants', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '019fc104-f4e1-7642-9736-e6d5dfaceeac', '019fc104-f551-7c69-b70e-4ba81d6e04f1', '019fc104-f42b-7451-ad34-360101e6f0bb', '019fc104-f485-7df6-ba4b-f9ea1f7a605a', '019fc104-f959-78a1-85cf-b54b5e2847b4', '019fc104-fa51-7cc1-86be-cc37ef1d2058', 'app_admin_grants', '019fc104-faa9-779d-997d-b63d69f26665', 'app_owner_grants', 'app', 'app', NULL, NULL, 'get_organization_id', 'app_memberships_mask_check', 'app_memberships_perm_check', NULL, NULL, NULL, NULL, '019fc104-fb69-7e31-ba8b-e7e1377de333', '019fc104-fbb0-7857-99af-321fc43e416c', 'admin', NULL);


SET session_replication_role TO DEFAULT;


