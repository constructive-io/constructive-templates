-- Revert: schemas/myapp_auth_private/tables/app_settings_device/columns/id/alterations/alt0000000001


ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN id DROP NOT NULL;


