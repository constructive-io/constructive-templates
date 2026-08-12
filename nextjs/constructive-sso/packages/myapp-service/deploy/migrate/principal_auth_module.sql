-- Deploy: migrate/principal_auth_module
-- made with <3 @ constructive.io

-- requires: migrate/phone_numbers_module


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

INSERT INTO metaschema_modules_public.principal_auth_module (
  id,
  database_id,
  schema_id,
  principals_table_id,
  principal_entities_table_id,
  principal_scope_overrides_table_id,
  users_table_id,
  sessions_table_id,
  session_credentials_table_id,
  audits_table_id,
  principals_table_name,
  create_principal_function,
  delete_principal_function,
  create_org_principal_function,
  delete_org_principal_function,
  create_org_api_key_function,
  revoke_org_api_key_function,
  api_name
) VALUES
  ('019fc105-17e4-7f36-b227-d0df3db8aca7', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c1b-7bde-9736-c30b1029bcc9', '019fc105-17e6-7798-944f-48a70446be95', '019fc105-18e2-7443-87f5-499f34c69054', '019fc105-19cc-790a-b75f-2797f5dd0ac3', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '019fc104-ff05-737a-9287-9dc91676dc85', '019fc104-ffd2-7869-bc0e-15e9e9f99044', '019fc105-13bf-7b4a-919a-37a5c5871c02', 'principals', 'create_principal', 'delete_principal', 'create_org_principal', 'delete_org_principal', 'create_org_api_key', 'revoke_org_api_key', 'auth');


SET session_replication_role TO DEFAULT;


