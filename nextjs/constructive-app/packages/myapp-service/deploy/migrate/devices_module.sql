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
  ('019fa2a1-6439-7e87-88b3-11b6a4cb46dc', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', '019fa2a1-6514-72da-b9d9-3bdb2c772b8c', '019fa2a1-643a-7595-bd9e-8c50e40166bc', 'auth_user_devices', 'app_settings_device');


SET session_replication_role TO DEFAULT;


