-- Deploy: migrate/profiles_module
-- made with <3 @ constructive.io

-- requires: migrate/principal_auth_module


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

INSERT INTO metaschema_modules_public.profiles_module (
  id,
  database_id,
  entity_field,
  schema_id,
  private_schema_id,
  public_schema_name,
  private_schema_name,
  table_id,
  table_name,
  profile_capabilities_table_id,
  profile_capabilities_table_name,
  profile_grants_table_id,
  profile_grants_table_name,
  profile_definition_grants_table_id,
  profile_definition_grants_table_name,
  membership_profiles_table_id,
  membership_profiles_table_name,
  profile_templates_table_id,
  profile_templates_table_name,
  scope,
  prefix,
  entity_table_id,
  actor_table_id,
  capabilities_table_id,
  memberships_table_id,
  api_name,
  private_api_name
) VALUES
  ('019feb75-7ca3-72af-a4e7-7b4b46b8421e', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', NULL, '019feb75-7ca3-764e-895e-58b77d9a5f1d', '019feb75-7cac-7b80-82dd-d18a956a7fdc', NULL, NULL, '019feb75-7cbc-7f64-80c7-6d62d91becf3', 'app_profiles', '019feb75-7cea-7eb1-916e-f55daf9eb5a8', 'app_profile_capabilities', '019feb75-7d06-7774-b81f-cba5ab585933', 'app_profile_grants', '019feb75-7d2a-7ec3-b6b1-f48a662aae14', 'app_profile_definition_grants', '019feb75-7d53-712f-8ea5-88ad311bf62b', 'app_membership_profiles', '019feb75-7d9f-7c4a-8d87-de64c404c98f', 'app_profile_templates', 'app', 'app', NULL, '019feb75-78e2-720e-82dc-c3ed84264ce8', '019feb75-797b-7fe2-bec7-40f720b33f6b', '019feb75-7b6d-72f4-9506-d4f1cf2023b7', 'admin', NULL),
  ('019feb75-8319-7704-8056-017d29440008', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'entity_id', '019feb75-7ca3-764e-895e-58b77d9a5f1d', '019feb75-7cac-7b80-82dd-d18a956a7fdc', NULL, NULL, '019feb75-831c-7cc1-b679-81c2a7b7fb3e', 'org_profiles', '019feb75-834e-7791-852a-6787b1c99790', 'org_profile_capabilities', '019feb75-836b-76bc-ab70-3f1198fcc4de', 'org_profile_grants', '019feb75-8398-75f1-8bf9-a5b1d207d637', 'org_profile_definition_grants', '019feb75-83c4-7884-89b2-49df42951434', 'org_membership_profiles', '019feb75-840b-7395-9b85-b717d612a64d', 'org_profile_templates', 'org', 'org', '019feb75-78e2-720e-82dc-c3ed84264ce8', '019feb75-78e2-720e-82dc-c3ed84264ce8', '019feb75-7ee2-77cd-aa83-c4d0fcd1a585', '019feb75-80eb-77cb-b434-9214851f2d3f', 'admin', NULL);


SET session_replication_role TO DEFAULT;


