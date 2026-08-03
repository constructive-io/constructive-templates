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
  ('019fbc96-8a81-795a-b7ee-26d700ccd3c6', '019fbc96-84d8-7d13-8acc-4c55ad35634c', NULL, '019fbc96-85d4-7f68-b449-545fb41b37d8', '019fbc96-8a81-7f7c-a48a-5a22ff96b8b1', NULL, NULL, '019fbc96-8aa7-7512-9409-53c9aa016b84', 'app_memberships', '019fbc96-8533-7560-9eea-55dbc7f7fcee', 'app_members', '019fbc96-8aea-7ad4-a849-ea060bfc84a5', 'app_membership_defaults', NULL, 'app_membership_settings', '019fbc96-8ce4-71cd-ad47-bef8de02e070', 'app_grants', '019fbc96-8533-7560-9eea-55dbc7f7fcee', '019fbc96-8702-7a94-9e81-560580adcaeb', '019fbc96-876c-7f34-b3b2-19c7fbae3f4f', '019fbc96-865b-7f26-a4f8-32df18a9e0ae', '019fbc96-86b0-7700-97e1-d05bfdc3b002', '019fbc96-8b25-77f2-ad95-aa9e09f99650', '019fbc96-8c19-7c0a-9052-1768cd93e552', 'app_admin_grants', '019fbc96-8c78-70da-8715-a89c618f1459', 'app_owner_grants', 'app', 'app', NULL, NULL, 'get_organization_id', 'app_memberships_mask_check', 'app_memberships_perm_check', NULL, NULL, NULL, NULL, '019fbc96-8d4b-7d3e-b20b-ecb9ad31487d', '019fbc96-8d8e-751f-a300-15e48f2b766f', 'admin', NULL),
  ('019fbc96-99b6-7b5e-85ee-b2b672d3b9a5', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'entity_id', '019fbc96-85d4-7f68-b449-545fb41b37d8', '019fbc96-8a81-7f7c-a48a-5a22ff96b8b1', NULL, NULL, '019fbc96-99bc-7201-9cda-85df7f4524ad', 'org_memberships', '019fbc96-9d0c-7703-9e77-3ad4e99213ab', 'org_members', '019fbc96-9a0f-7565-9c5b-19990520d73c', 'org_membership_defaults', '019fbc96-9b14-7a84-b273-cc96a45854b8', 'org_membership_settings', '019fbc96-a02d-7797-a968-a4f7aef00b4a', 'org_grants', '019fbc96-8533-7560-9eea-55dbc7f7fcee', '019fbc96-948e-7191-adb1-ab09ac90689e', '019fbc96-9542-74ef-b1d3-8502bfd69283', '019fbc96-93c9-79f2-8dcb-8d72b5725eaa', '019fbc96-943e-7ea4-b55b-ac4ad60ff0e9', '019fbc96-9a64-745c-bc54-f97fa0b95d25', '019fbc96-9de0-7944-9027-6aa06491ef19', 'org_admin_grants', '019fbc96-9e82-73a2-b554-259d21eea97d', 'org_owner_grants', 'org', 'org', '019fbc96-8533-7560-9eea-55dbc7f7fcee', NULL, 'get_organization_id', 'org_memberships_mask_check', 'org_memberships_perm_check', 'org_memberships_mask_ids', 'org_memberships_perm_ids', 'org_memberships_ids', '019fbc96-9f36-7e20-ac14-923b764c3ac4', '019fbc96-a0ea-7e5e-9a0b-1c224ef18e4e', '019fbc96-a17b-7b9b-94d6-a303d8932007', 'admin', NULL);


SET session_replication_role TO DEFAULT;


