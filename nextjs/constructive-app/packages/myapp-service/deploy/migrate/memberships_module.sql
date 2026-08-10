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
  capabilities_table_id,
  default_capabilities_table_id,
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
  capability_default_capabilities_table_id,
  capability_default_grants_table_id,
  api_name,
  private_api_name
) VALUES
  ('019feb75-7b5b-7c99-b2eb-cea32a9f0691', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', NULL, '019feb75-7938-77e1-8f66-717a7e6e05de', '019feb75-7b5c-710b-a201-95a6bb0962be', NULL, NULL, '019feb75-7b6d-72f4-9506-d4f1cf2023b7', 'app_memberships', '019feb75-78e2-720e-82dc-c3ed84264ce8', 'app_members', '019feb75-7b8c-7674-8aa6-9f3e7822b6d2', 'app_membership_defaults', NULL, 'app_membership_settings', '019feb75-7c2b-7756-979f-e00c324dac19', 'app_grants', '019feb75-78e2-720e-82dc-c3ed84264ce8', '019feb75-79c8-7b1d-97d4-30cd885258c7', '019feb75-79ee-72c1-a134-d898911d2b82', '019feb75-797b-7fe2-bec7-40f720b33f6b', '019feb75-79a7-7220-a4a5-518075c2fa2c', '019feb75-7ba3-7ed0-ab1f-c1d2324b118d', '019feb75-7bf0-7c61-a442-b33dfe0ad7f1', 'app_admin_grants', '019feb75-7c0e-748e-9569-e50965f21a18', 'app_owner_grants', 'app', 'app', NULL, NULL, 'get_organization_id', 'app_memberships_mask_check', 'app_memberships_perm_check', NULL, NULL, NULL, NULL, '019feb75-7c4a-7e32-9627-f808c8005aec', '019feb75-7c5d-7c2e-ac56-9641ad127fd0', 'admin', NULL),
  ('019feb75-80e6-7bc8-a805-3a38f48f2fea', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'entity_id', '019feb75-7938-77e1-8f66-717a7e6e05de', '019feb75-7b5c-710b-a201-95a6bb0962be', NULL, NULL, '019feb75-80eb-77cb-b434-9214851f2d3f', 'org_memberships', '019feb75-81a1-73c4-921f-2f503423abb6', 'org_members', '019feb75-8104-74c1-9285-19272f3f36c9', 'org_membership_defaults', '019feb75-8141-7843-8e56-03ed77e58e70', 'org_membership_settings', '019feb75-8278-7bcd-98f0-8fbbd5ad1f2d', 'org_grants', '019feb75-78e2-720e-82dc-c3ed84264ce8', '019feb75-7f1b-74ca-9a57-a7a77a490ba9', '019feb75-7f42-7e7f-adeb-651d0ecc673c', '019feb75-7ee2-77cd-aa83-c4d0fcd1a585', '019feb75-7f06-74af-8081-279dccbef6aa', '019feb75-811d-7201-be72-690e752bae80', '019feb75-81ea-722f-92a4-ae498d5ca9f1', 'org_admin_grants', '019feb75-8210-74c4-a398-da72dd99aad2', 'org_owner_grants', 'org', 'org', '019feb75-78e2-720e-82dc-c3ed84264ce8', NULL, 'get_organization_id', 'org_memberships_mask_check', 'org_memberships_perm_check', 'org_memberships_mask_ids', 'org_memberships_perm_ids', 'org_memberships_ids', '019feb75-8236-75fb-9dc6-db689017ed5d', '019feb75-82a2-791d-93ce-2b9a34a3b7d6', '019feb75-82be-79b8-8469-ac0eb8e697a7', 'admin', NULL);


SET session_replication_role TO DEFAULT;


