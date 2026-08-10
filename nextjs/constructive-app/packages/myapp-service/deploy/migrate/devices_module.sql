-- Deploy: migrate/devices_module
-- made with <3 @ constructive.io

-- requires: migrate/connected_accounts_module


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

INSERT INTO metaschema_modules_public.devices_module (
  id,
  database_id,
  schema_id,
  user_devices_table_id,
  device_settings_table_id,
  user_devices_table_name,
  device_settings_table_name
) VALUES
  ('019feb75-8895-76e4-81e8-b458d41d2422', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8695-7e24-8b0b-8db166cbaf4a', '019feb75-88c9-752b-8ef8-9966727a744c', '019feb75-8895-7d60-91c8-d183e531853c', 'auth_user_devices', 'app_settings_device');


SET session_replication_role TO DEFAULT;


