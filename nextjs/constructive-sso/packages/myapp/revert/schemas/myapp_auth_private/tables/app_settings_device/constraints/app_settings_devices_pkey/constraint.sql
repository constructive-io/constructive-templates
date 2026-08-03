-- Revert: schemas/myapp_auth_private/tables/app_settings_device/constraints/app_settings_devices_pkey/constraint


ALTER TABLE myapp_auth_private.app_settings_device 
  DROP CONSTRAINT app_settings_devices_pkey;


