-- Deploy: migrate/rls_module
-- made with <3 @ constructive.io

-- requires: migrate/rate_limits_module


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

INSERT INTO metaschema_modules_public.rls_module (
  id,
  database_id,
  schema_id,
  private_schema_id,
  session_credentials_table_id,
  sessions_table_id,
  users_table_id,
  authenticate,
  authenticate_strict,
  "current_role",
  current_role_id,
  api_name,
  private_api_name
) VALUES
  ('019fbc96-c130-71b2-9cee-36fac3ce48ae', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c130-7558-9bec-78482a963cfe', '019fbc96-ae06-75fc-96c3-df2484d13ce6', '019fbc96-af80-75e3-9b05-4a449fcabc73', '019fbc96-ae3f-7843-8d56-55dc4da7a445', '019fbc96-8533-7560-9eea-55dbc7f7fcee', 'authenticate', 'authenticate_strict', 'current_user', 'current_user_id', 'auth', NULL);


SET session_replication_role TO DEFAULT;


