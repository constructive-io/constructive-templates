-- Deploy: migrate/webauthn_credentials_module
-- made with <3 @ constructive.io

-- requires: migrate/webauthn_auth_module


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

INSERT INTO metaschema_modules_public.webauthn_credentials_module (
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
  ('019fc105-0f2c-72b3-ae3d-a3b65feaed05', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c8d-72ee-983e-7d7c1610c7f5', '019fc105-0cbe-7083-b3b1-f8ed102c2bb0', '019fc105-0f2e-795d-b36f-44859808a931', '019fc104-f2f4-73b2-abcd-47aa47fa7997', 'webauthn_credentials', 'auth', NULL);


SET session_replication_role TO DEFAULT;


