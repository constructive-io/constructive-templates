-- Revert: schemas/myapp_auth_private/tables/app_settings_device/columns/require_mfa_new_device/column


ALTER TABLE myapp_auth_private.app_settings_device 
  DROP COLUMN require_mfa_new_device RESTRICT;


