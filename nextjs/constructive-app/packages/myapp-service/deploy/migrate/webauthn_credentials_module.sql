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
  ('019feb75-8ad2-7a38-a427-d7de46121037', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a0e-7a45-8898-85dfd6f8e078', '019feb75-8a17-7f4e-89e7-80c6ce5095d1', '019feb75-8ad3-74a3-a82a-14d661c634a7', '019feb75-78e2-720e-82dc-c3ed84264ce8', 'webauthn_credentials', 'auth', NULL);


SET session_replication_role TO DEFAULT;


