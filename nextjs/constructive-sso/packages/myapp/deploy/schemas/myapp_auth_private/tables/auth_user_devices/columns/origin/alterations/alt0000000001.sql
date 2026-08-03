-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/columns/origin/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/columns/origin/column


COMMENT ON COLUMN myapp_auth_private.auth_user_devices.origin IS E'Request origin (domain) where the device was first seen';

