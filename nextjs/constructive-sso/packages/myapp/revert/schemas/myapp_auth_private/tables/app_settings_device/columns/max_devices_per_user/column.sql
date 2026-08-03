-- Revert: schemas/myapp_auth_private/tables/app_settings_device/columns/max_devices_per_user/column


ALTER TABLE myapp_auth_private.app_settings_device 
  DROP COLUMN max_devices_per_user RESTRICT;


