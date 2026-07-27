-- Revert: schemas/myapp_auth_private/tables/app_settings_device/columns/enable_device_tracking/alterations/alt0000000001


ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN enable_device_tracking DROP NOT NULL;


