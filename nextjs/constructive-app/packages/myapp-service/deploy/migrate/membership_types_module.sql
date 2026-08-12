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
  ('019feb75-7938-75f1-af77-4f0497abaf9b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7938-77e1-8f66-717a7e6e05de', '019feb75-7940-7758-b3b9-f53e917bff10', 'membership_types');


SET session_replication_role TO DEFAULT;


