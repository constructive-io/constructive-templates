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
  ('019feb75-9148-75bb-8495-8cc7d6b4ee3f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-89de-7d6c-a0e8-f04fbeb7d8d9', '019feb75-9149-78eb-8455-bb07f20208c6', '019feb75-9184-707a-8a09-d8870969fe13', '019feb75-91bb-7f0a-9d9d-fd451ffa01f4', '019feb75-78e2-720e-82dc-c3ed84264ce8', '019feb75-869f-77e5-b1bd-2954e3f87b89', '019feb75-86dd-7d4b-9a7a-f22c7ff73486', '019feb75-8da3-75f1-b809-0a4c23d44795', 'principals', 'create_principal', 'delete_principal', 'create_org_principal', 'delete_org_principal', 'create_org_api_key', 'revoke_org_api_key', 'auth');


SET session_replication_role TO DEFAULT;


