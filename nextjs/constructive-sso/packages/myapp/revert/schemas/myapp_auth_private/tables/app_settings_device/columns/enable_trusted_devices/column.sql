-- Revert: schemas/myapp_auth_private/tables/app_settings_device/columns/enable_trusted_devices/column


ALTER TABLE myapp_auth_private.app_settings_device 
  DROP COLUMN enable_trusted_devices RESTRICT;


