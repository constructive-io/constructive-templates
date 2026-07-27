-- Deploy: migrate/memberships_module
-- made with <3 @ constructive.io

-- requires: migrate/webauthn_settings


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
  ('019fa2a1-5560-7075-8fe6-1ac7e4dd0e49', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', NULL, '019fa2a1-50aa-7d8f-841d-7965af0951a1', '019fa2a1-5560-76ce-bbf2-797a38176260', NULL, NULL, '019fa2a1-558c-7bc2-b6aa-c20fbc1f8f2a', 'app_memberships', '019fa2a1-5022-77c8-9de2-2ef6079855de', 'app_members', '019fa2a1-55cd-7a92-9979-3b8d9bc899b3', 'app_membership_defaults', NULL, 'app_membership_settings', '019fa2a1-57ac-73c9-bd3e-65e6d7444548', 'app_grants', '019fa2a1-5022-77c8-9de2-2ef6079855de', '019fa2a1-51d7-7525-a82f-f18b7765f445', '019fa2a1-5245-7943-99d6-ab69b0046c4a', '019fa2a1-5131-7642-b999-a3637fd3f1a5', '019fa2a1-5182-755b-a123-1190a88df2cf', '019fa2a1-5607-704a-bacc-b1c2d99357f7', '019fa2a1-56f9-78f0-931f-4812580b70dd', 'app_admin_grants', '019fa2a1-574e-737f-9b1f-25f5eb8d9dd6', 'app_owner_grants', 'app', 'app', NULL, NULL, 'get_organization_id', 'app_memberships_mask_check', 'app_memberships_perm_check', NULL, NULL, NULL, NULL, '019fa2a1-5813-7ca8-bd2f-4f5cde8b71a6', '019fa2a1-5856-7452-ad3a-45b1f4c4fc67', 'admin', NULL);


SET session_replication_role TO DEFAULT;


