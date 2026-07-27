-- Deploy: schemas/myapp_auth_private/tables/app_settings_device/columns/id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_device/table
-- requires: schemas/myapp_auth_private/tables/app_settings_device/columns/id/column


ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN id SET NOT NULL;

