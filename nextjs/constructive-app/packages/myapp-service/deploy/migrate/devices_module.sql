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
  ('019fbc96-bac1-7b9f-97d7-cfc762ecba4a', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ae06-75fc-96c3-df2484d13ce6', '019fbc96-bbf2-7aef-8d13-b34586d8c5f2', '019fbc96-bac2-7190-b634-e54079d7304b', 'auth_user_devices', 'app_settings_device');


SET session_replication_role TO DEFAULT;


