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
  ('019fc105-0471-734b-9cc2-d14c463177bb', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fee2-7758-ae40-4fdc60702a9e', '019fc105-0471-784c-9f94-cb05526be1f0', 'session_secrets', '019fc104-ff05-737a-9287-9dc91676dc85');


SET session_replication_role TO DEFAULT;


