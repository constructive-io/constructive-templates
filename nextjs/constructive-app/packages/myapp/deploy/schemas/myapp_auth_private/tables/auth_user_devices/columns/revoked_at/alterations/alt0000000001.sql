-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/columns/revoked_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/columns/revoked_at/column


COMMENT ON COLUMN myapp_auth_private.auth_user_devices.revoked_at IS E'Timestamp when this device was revoked; non-NULL means device is no longer valid';

