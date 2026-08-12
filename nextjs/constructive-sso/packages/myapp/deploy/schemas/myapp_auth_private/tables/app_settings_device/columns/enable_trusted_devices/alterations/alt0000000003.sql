-- Deploy: schemas/myapp_auth_private/tables/app_settings_device/columns/enable_trusted_devices/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_device/columns/enable_trusted_devices/column


COMMENT ON COLUMN myapp_auth_private.app_settings_device.enable_trusted_devices IS E'Whether trusted devices can skip MFA challenges on subsequent sign-ins';

