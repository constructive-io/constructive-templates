-- Revert: schemas/myapp_auth_private/tables/app_settings_device/columns/enable_trusted_devices/alterations/alt0000000002


ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN enable_trusted_devices DROP DEFAULT;


