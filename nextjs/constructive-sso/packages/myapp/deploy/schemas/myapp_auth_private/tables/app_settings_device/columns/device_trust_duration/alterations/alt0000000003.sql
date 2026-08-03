-- Deploy: schemas/myapp_auth_private/tables/app_settings_device/columns/device_trust_duration/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_device/columns/device_trust_duration/column


COMMENT ON COLUMN myapp_auth_private.app_settings_device.device_trust_duration IS 'How long a device remains trusted after user explicitly marks it as trusted via MFA';

