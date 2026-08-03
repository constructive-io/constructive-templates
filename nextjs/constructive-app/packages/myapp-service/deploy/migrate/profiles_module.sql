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
  profile_permissions_table_id,
  profile_permissions_table_name,
  profile_grants_table_id,
  profile_grants_table_name,
  profile_definition_grants_table_id,
  profile_definition_grants_table_name,
  profile_templates_table_id,
  profile_templates_table_name,
  scope,
  prefix,
  entity_table_id,
  actor_table_id,
  permissions_table_id,
  memberships_table_id,
  api_name,
  private_api_name
) VALUES
  ('019fbc96-8e33-7c2e-a240-71ec252dacc9', '019fbc96-84d8-7d13-8acc-4c55ad35634c', NULL, '019fbc96-8e34-7092-8399-48a2a3e2d57a', '019fbc96-8e55-7985-8a70-cd6ede5e4c5c', NULL, NULL, '019fbc96-8e7e-7b0d-8c4a-b7c306b27a4e', 'app_profiles', '019fbc96-8f0f-7a36-991e-55003b1a091b', 'app_profile_permissions', '019fbc96-8f6f-7dbc-bda7-38e596c2f2a8', 'app_profile_grants', '019fbc96-8fe6-75fe-811a-e81911dcf9c4', 'app_profile_definition_grants', '019fbc96-9098-7c7b-a3d2-0a6ca2ae13dd', 'app_profile_templates', 'app', 'app', NULL, '019fbc96-8533-7560-9eea-55dbc7f7fcee', '019fbc96-865b-7f26-a4f8-32df18a9e0ae', '019fbc96-8aa7-7512-9409-53c9aa016b84', 'admin', NULL),
  ('019fbc96-a290-7431-97e1-22e068795469', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'entity_id', '019fbc96-8e34-7092-8399-48a2a3e2d57a', '019fbc96-8e55-7985-8a70-cd6ede5e4c5c', NULL, NULL, '019fbc96-a293-7833-9a15-03f67f8888d1', 'org_profiles', '019fbc96-a37a-7979-a78d-aec6597cf407', 'org_profile_permissions', '019fbc96-a401-7297-aa81-80e925299b67', 'org_profile_grants', '019fbc96-a4bb-72dd-a78e-bc606ec1fa92', 'org_profile_definition_grants', '019fbc96-a5ab-7844-9c3f-26f638f94b2d', 'org_profile_templates', 'org', 'org', '019fbc96-8533-7560-9eea-55dbc7f7fcee', '019fbc96-8533-7560-9eea-55dbc7f7fcee', '019fbc96-93c9-79f2-8dcb-8d72b5725eaa', '019fbc96-99bc-7201-9cda-85df7f4524ad', 'admin', NULL);


SET session_replication_role TO DEFAULT;


