-- Deploy: schemas/myapp_auth_private/tables/app_settings_device/columns/require_mfa_new_device/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_device/table
-- requires: schemas/myapp_auth_private/tables/app_settings_device/columns/require_mfa_new_device/column


ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN require_mfa_new_device SET NOT NULL;

