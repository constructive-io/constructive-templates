-- Deploy: migrate/connected_accounts_module
-- made with <3 @ constructive.io

-- requires: migrate/view


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

INSERT INTO metaschema_modules_public.connected_accounts_module (
  id,
  database_id,
  schema_id,
  private_schema_id,
  table_id,
  owner_table_id,
  table_name,
  api_name,
  private_api_name
) VALUES
  ('019feb75-8b41-7e2e-9296-9fd498a62799', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a0e-7a45-8898-85dfd6f8e078', '019feb75-8a17-7f4e-89e7-80c6ce5095d1', '019feb75-8b42-77a4-83be-695a8efb04b9', '019feb75-78e2-720e-82dc-c3ed84264ce8', 'connected_accounts', 'auth', NULL);


SET session_replication_role TO DEFAULT;


