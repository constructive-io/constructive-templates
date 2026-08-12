-- Deploy: schemas/myapp_auth_private/tables/app_settings_device/columns/max_devices_per_user/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_device/table
-- requires: schemas/myapp_auth_private/tables/app_settings_device/columns/max_devices_per_user/column


ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN max_devices_per_user SET DEFAULT 50;

