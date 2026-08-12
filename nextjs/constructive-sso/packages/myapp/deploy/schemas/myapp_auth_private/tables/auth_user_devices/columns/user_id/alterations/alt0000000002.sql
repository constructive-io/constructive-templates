-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/columns/user_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/columns/user_id/column


COMMENT ON COLUMN myapp_auth_private.auth_user_devices.user_id IS 'User who owns this device record';

