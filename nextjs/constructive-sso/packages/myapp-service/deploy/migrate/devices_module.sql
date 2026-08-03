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
  ('019fc105-0761-782d-9947-6d08a6973028', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fee2-7758-ae40-4fdc60702a9e', '019fc105-0837-7cb1-9c78-199827e949c6', '019fc105-0761-7e41-b7c9-5d562a017d29', 'auth_user_devices', 'app_settings_device');


SET session_replication_role TO DEFAULT;


