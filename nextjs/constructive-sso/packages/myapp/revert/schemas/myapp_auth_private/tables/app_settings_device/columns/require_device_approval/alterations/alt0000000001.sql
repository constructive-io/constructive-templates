-- Revert: schemas/myapp_auth_private/tables/app_settings_device/columns/require_device_approval/alterations/alt0000000001


ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN require_device_approval DROP NOT NULL;


