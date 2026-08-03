-- Revert: schemas/myapp_auth_private/tables/app_settings_device/columns/enable_device_tracking/column


ALTER TABLE myapp_auth_private.app_settings_device 
  DROP COLUMN enable_device_tracking RESTRICT;


