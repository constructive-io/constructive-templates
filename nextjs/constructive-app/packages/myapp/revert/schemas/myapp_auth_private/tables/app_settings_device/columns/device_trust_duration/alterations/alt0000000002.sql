-- Revert: schemas/myapp_auth_private/tables/app_settings_device/columns/device_trust_duration/alterations/alt0000000002


ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN device_trust_duration DROP DEFAULT;


