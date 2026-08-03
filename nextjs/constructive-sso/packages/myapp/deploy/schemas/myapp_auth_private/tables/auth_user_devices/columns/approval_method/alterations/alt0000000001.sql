-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/columns/approval_method/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/columns/approval_method/column


COMMENT ON COLUMN myapp_auth_private.auth_user_devices.approval_method IS E'Method used to approve the device (e.g. email_link, admin, auto)';

