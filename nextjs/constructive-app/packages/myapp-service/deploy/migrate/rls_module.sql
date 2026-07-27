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
  ('019fa2a1-68d2-7fee-b722-837aac0a7e15', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', '019fa2a1-5c8d-7633-a186-023c9c2285e6', '019fa2a1-5bbc-7d2a-a42f-af8235516fb4', '019fa2a1-5022-77c8-9de2-2ef6079855de', 'authenticate', 'authenticate_strict', 'current_user', 'current_user_id', 'auth', NULL);


SET session_replication_role TO DEFAULT;


