-- Revert: schemas/myapp_auth_private/tables/app_settings_device/columns/created_at/alterations/alt0000000001


ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN created_at DROP DEFAULT;


