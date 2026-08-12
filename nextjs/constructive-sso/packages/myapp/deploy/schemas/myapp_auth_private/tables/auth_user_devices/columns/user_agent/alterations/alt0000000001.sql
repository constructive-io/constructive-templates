-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/columns/user_agent/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/columns/user_agent/column


COMMENT ON COLUMN myapp_auth_private.auth_user_devices.user_agent IS E'Browser or client user-agent string captured when device was first seen';

