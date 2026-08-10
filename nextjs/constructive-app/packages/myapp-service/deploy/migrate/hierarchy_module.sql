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
  default_capabilities
) VALUES
  ('019feb75-843e-768b-9d8c-abd53d5e582b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'entity_id', '019feb75-7938-77e1-8f66-717a7e6e05de', '019feb75-7b5c-710b-a201-95a6bb0962be', '019feb75-8440-7e28-b081-063629bcb1bb', 'org_chart_edges', '019feb75-8470-79ea-8c87-7a37d614490b', 'org_hierarchy_sprts', '019feb75-8488-7feb-8444-2e121d3adf86', 'org_chart_edge_grants', '019feb75-78e2-720e-82dc-c3ed84264ce8', '019feb75-78e2-720e-82dc-c3ed84264ce8', 'org', 'org', 'myapp_memberships_private', 'org_hierarchy_sprts', 'org_rebuild_org_hierarchy_sprt', 'org_get_subordinates', 'org_get_managers', 'org_is_manager_of', '{}');


SET session_replication_role TO DEFAULT;


