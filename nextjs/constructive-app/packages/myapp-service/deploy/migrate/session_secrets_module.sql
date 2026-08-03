-- Deploy: migrate/session_secrets_module
-- made with <3 @ constructive.io

-- requires: migrate/rls_module


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

INSERT INTO metaschema_modules_public.session_secrets_module (
  id,
  database_id,
  schema_id,
  table_id,
  table_name,
  sessions_table_id
) VALUES
  ('019fbc96-b686-70a4-aa0a-691e961bf027', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ae06-75fc-96c3-df2484d13ce6', '019fbc96-b686-765d-895b-6bf64df652aa', 'session_secrets', '019fbc96-ae3f-7843-8d56-55dc4da7a445');


SET session_replication_role TO DEFAULT;


