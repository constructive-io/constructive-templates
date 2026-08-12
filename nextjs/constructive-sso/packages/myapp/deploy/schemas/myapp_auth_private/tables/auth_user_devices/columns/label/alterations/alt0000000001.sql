-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/columns/label/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/columns/label/column


COMMENT ON COLUMN myapp_auth_private.auth_user_devices.label IS E'User-facing device label derived from user agent (e.g. Chrome on macOS)';

