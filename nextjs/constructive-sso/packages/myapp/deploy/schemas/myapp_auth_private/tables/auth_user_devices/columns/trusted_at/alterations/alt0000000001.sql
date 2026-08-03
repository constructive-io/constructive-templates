-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/columns/trusted_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/columns/trusted_at/column


COMMENT ON COLUMN myapp_auth_private.auth_user_devices.trusted_at IS 'Timestamp when the user explicitly marked this device as trusted';

