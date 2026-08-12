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
  ('019fc105-0c1b-7860-94cd-a913caf91d88', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c1b-7bde-9736-c30b1029bcc9', '019fc104-fee2-7758-ae40-4fdc60702a9e', '019fc104-ffd2-7869-bc0e-15e9e9f99044', '019fc104-ff05-737a-9287-9dc91676dc85', '019fc104-f2f4-73b2-abcd-47aa47fa7997', 'authenticate', 'authenticate_strict', 'current_user', 'current_user_id', 'auth', NULL);


SET session_replication_role TO DEFAULT;


