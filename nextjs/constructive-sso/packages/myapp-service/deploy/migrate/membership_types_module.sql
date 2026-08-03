-- Deploy: migrate/membership_types_module
-- made with <3 @ constructive.io

-- requires: migrate/limits_module


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

INSERT INTO metaschema_modules_public.membership_types_module (
  id,
  database_id,
  schema_id,
  table_id,
  table_name
) VALUES
  ('019fc104-f39c-70b6-a9a2-7825e20af170', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f39c-7300-895c-30b0b61a670e', '019fc104-f3b3-7db4-9f2a-97645203d652', 'membership_types');


SET session_replication_role TO DEFAULT;


