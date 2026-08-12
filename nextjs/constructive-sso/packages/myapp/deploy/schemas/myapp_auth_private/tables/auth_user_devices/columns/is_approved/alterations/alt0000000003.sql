-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/columns/is_approved/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/columns/is_approved/column


COMMENT ON COLUMN myapp_auth_private.auth_user_devices.is_approved IS E'Whether this device has been approved for login (via email confirmation, admin, or auto on first sign-up)';

