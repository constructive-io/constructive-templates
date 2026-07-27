-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/columns/is_trusted/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/columns/is_trusted/column


COMMENT ON COLUMN myapp_auth_private.auth_user_devices.is_trusted IS 'Whether the user explicitly trusted this device after MFA verification';

