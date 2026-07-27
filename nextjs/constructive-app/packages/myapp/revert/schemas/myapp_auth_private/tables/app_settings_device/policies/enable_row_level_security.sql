-- Revert: schemas/myapp_auth_private/tables/app_settings_device/policies/enable_row_level_security


ALTER TABLE myapp_auth_private.app_settings_device 
  DISABLE ROW LEVEL SECURITY;


