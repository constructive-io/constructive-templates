-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/columns/first_seen_ip/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/columns/first_seen_ip/column


COMMENT ON COLUMN myapp_auth_private.auth_user_devices.first_seen_ip IS 'IP address when this device was first seen';

