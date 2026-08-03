-- Deploy: migrate/hierarchy_module
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

INSERT INTO metaschema_modules_public.hierarchy_module (
  id,
  database_id,
  entity_field,
  schema_id,
  private_schema_id,
  chart_edges_table_id,
  chart_edges_table_name,
  hierarchy_sprt_table_id,
  hierarchy_sprt_table_name,
  chart_edge_grants_table_id,
  chart_edge_grants_table_name,
  entity_table_id,
  users_table_id,
  scope,
  prefix,
  private_schema_name,
  sprt_table_name,
  rebuild_hierarchy_function,
  get_subordinates_function,
  get_managers_function,
  is_manager_of_function,
  default_permissions
) VALUES
  ('019fbc96-a676-7ece-b3a0-91f0ce257ade', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'entity_id', '019fbc96-85d4-7f68-b449-545fb41b37d8', '019fbc96-8a81-7f7c-a48a-5a22ff96b8b1', '019fbc96-a679-7751-89c9-def7076eb2dc', 'org_chart_edges', '019fbc96-a743-768f-b50d-25d599543ea0', 'org_hierarchy_sprts', '019fbc96-a7ad-7938-b378-05541b782a3c', 'org_chart_edge_grants', '019fbc96-8533-7560-9eea-55dbc7f7fcee', '019fbc96-8533-7560-9eea-55dbc7f7fcee', 'org', 'org', 'myapp_memberships_private', 'org_hierarchy_sprts', 'org_rebuild_org_hierarchy_sprt', 'org_get_subordinates', 'org_get_managers', 'org_is_manager_of', '{}');


SET session_replication_role TO DEFAULT;


