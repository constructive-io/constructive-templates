-- Revert: schemas/myapp_auth_private/tables/app_settings_device/columns/require_device_approval/column


ALTER TABLE myapp_auth_private.app_settings_device 
  DROP COLUMN require_device_approval RESTRICT;


