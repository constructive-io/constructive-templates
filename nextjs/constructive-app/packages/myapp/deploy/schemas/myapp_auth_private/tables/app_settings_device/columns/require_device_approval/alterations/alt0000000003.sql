-- Deploy: schemas/myapp_auth_private/tables/app_settings_device/columns/require_device_approval/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_device/columns/require_device_approval/column


COMMENT ON COLUMN myapp_auth_private.app_settings_device.require_device_approval IS 'Whether to require email approval when logging in from an unrecognized device';

