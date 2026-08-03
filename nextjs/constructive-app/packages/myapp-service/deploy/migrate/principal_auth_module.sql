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
  ('019fbc96-d947-7c91-b954-7bc85c03877d', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c130-7558-9bec-78482a963cfe', '019fbc96-d949-70f9-ae75-050b81c28f49', '019fbc96-dab8-77ea-88cc-6c09b415cd93', '019fbc96-dbf8-7743-a147-16f1aad029b3', '019fbc96-8533-7560-9eea-55dbc7f7fcee', '019fbc96-ae3f-7843-8d56-55dc4da7a445', '019fbc96-af80-75e3-9b05-4a449fcabc73', '019fbc96-d430-750d-8b5e-429956001965', 'principals', 'create_principal', 'delete_principal', 'create_org_principal', 'delete_org_principal', 'create_org_api_key', 'revoke_org_api_key', 'auth');


SET session_replication_role TO DEFAULT;


