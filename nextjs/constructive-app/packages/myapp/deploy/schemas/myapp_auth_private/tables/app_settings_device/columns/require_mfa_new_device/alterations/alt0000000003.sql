-- Deploy: schemas/myapp_auth_private/tables/app_settings_device/columns/require_mfa_new_device/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_device/columns/require_mfa_new_device/column


COMMENT ON COLUMN myapp_auth_private.app_settings_device.require_mfa_new_device IS 'Whether to require MFA verification when logging in from an unrecognized device';

