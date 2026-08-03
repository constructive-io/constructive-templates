-- Deploy: schemas/myapp_auth_private/tables/app_settings_device/columns/require_device_approval/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_device/table
-- requires: schemas/myapp_auth_private/tables/app_settings_device/columns/require_device_approval/column


ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN require_device_approval SET DEFAULT false;

