-- Deploy: migrate/users_module
-- made with <3 @ constructive.io

-- requires: migrate/user_state_module


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

INSERT INTO metaschema_modules_public.users_module (
  id,
  database_id,
  schema_id,
  table_id,
  table_name,
  type_table_id,
  type_table_name,
  api_name,
  private_api_name
) VALUES
  ('019fbc96-8517-7e97-8eef-6dd9df9d59e3', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8518-71f6-b5dd-e68f7390e1e2', '019fbc96-8533-7560-9eea-55dbc7f7fcee', 'users', '019fbc96-8583-7576-a215-4812842342ee', 'role_types', 'auth', NULL);


SET session_replication_role TO DEFAULT;


