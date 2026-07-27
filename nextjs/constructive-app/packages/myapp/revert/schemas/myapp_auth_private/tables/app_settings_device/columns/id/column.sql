-- Revert: schemas/myapp_auth_private/tables/app_settings_device/columns/id/column


ALTER TABLE myapp_auth_private.app_settings_device 
  DROP COLUMN id RESTRICT;


