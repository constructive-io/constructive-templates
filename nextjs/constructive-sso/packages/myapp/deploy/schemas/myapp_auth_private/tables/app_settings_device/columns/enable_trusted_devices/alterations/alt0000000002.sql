-- Deploy: schemas/myapp_auth_private/tables/app_settings_device/columns/enable_trusted_devices/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_device/table
-- requires: schemas/myapp_auth_private/tables/app_settings_device/columns/enable_trusted_devices/column


ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN enable_trusted_devices SET DEFAULT false;

