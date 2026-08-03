-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/columns/approved_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/columns/approved_at/column


COMMENT ON COLUMN myapp_auth_private.auth_user_devices.approved_at IS 'Timestamp when this device was approved for login';

