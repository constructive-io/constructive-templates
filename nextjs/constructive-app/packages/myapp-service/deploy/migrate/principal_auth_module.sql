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
  ('019fa2a1-72e8-7217-b974-86e7d4e0a6e1', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', '019fa2a1-72e9-73af-9d7e-46dedcbda5ad', '019fa2a1-73db-7463-ae1b-141b8847e6ed', '019fa2a1-74cf-7e12-bb6b-5a4db46c9efb', '019fa2a1-5022-77c8-9de2-2ef6079855de', '019fa2a1-5bbc-7d2a-a42f-af8235516fb4', '019fa2a1-5c8d-7633-a186-023c9c2285e6', '019fa2a1-703c-73a4-bcd4-ef0ed194b005', 'principals', 'create_principal', 'delete_principal', 'create_org_principal', 'delete_org_principal', 'create_org_api_key', 'revoke_org_api_key', 'auth');


SET session_replication_role TO DEFAULT;


