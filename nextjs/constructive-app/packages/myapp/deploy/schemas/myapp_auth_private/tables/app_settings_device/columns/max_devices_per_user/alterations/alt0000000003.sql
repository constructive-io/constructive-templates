-- Deploy: schemas/myapp_auth_private/tables/app_settings_device/columns/max_devices_per_user/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_device/columns/max_devices_per_user/column


COMMENT ON COLUMN myapp_auth_private.app_settings_device.max_devices_per_user IS E'Maximum number of active (non-revoked) device records per user; oldest devices are auto-revoked when exceeded';

