-- Revert: schemas/myapp_auth_private/tables/app_settings_device/columns/device_trust_duration/column


ALTER TABLE myapp_auth_private.app_settings_device 
  DROP COLUMN device_trust_duration RESTRICT;


