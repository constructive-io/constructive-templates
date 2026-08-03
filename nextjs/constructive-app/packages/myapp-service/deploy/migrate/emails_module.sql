-- Deploy: migrate/emails_module
-- made with <3 @ constructive.io

-- requires: migrate/devices_module


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

INSERT INTO metaschema_modules_public.emails_module (
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
  ('019fbc96-c1c4-7bce-85ec-ea1cc78d22e4', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c1c4-7d76-8017-c296fd0375c5', '019fbc96-c208-7fd4-a19a-6650fdd93969', '019fbc96-c250-7c44-b81a-baa69ea7f678', '019fbc96-8533-7560-9eea-55dbc7f7fcee', 'emails', 'auth', NULL);


SET session_replication_role TO DEFAULT;


