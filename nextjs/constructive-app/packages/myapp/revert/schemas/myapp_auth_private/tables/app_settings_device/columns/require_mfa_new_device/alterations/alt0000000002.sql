-- Revert: schemas/myapp_auth_private/tables/app_settings_device/columns/require_mfa_new_device/alterations/alt0000000002


ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN require_mfa_new_device DROP DEFAULT;


