-- Deploy: schemas/myapp_auth_private/tables/app_settings_device/policies/enable_row_level_security
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_device/table


ALTER TABLE myapp_auth_private.app_settings_device 
  ENABLE ROW LEVEL SECURITY;

