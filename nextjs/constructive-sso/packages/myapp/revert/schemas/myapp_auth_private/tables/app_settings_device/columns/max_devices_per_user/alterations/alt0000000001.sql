-- Revert: schemas/myapp_auth_private/tables/app_settings_device/columns/max_devices_per_user/alterations/alt0000000001


ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN max_devices_per_user DROP NOT NULL;


