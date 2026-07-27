-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/columns/last_seen_at/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/columns/last_seen_at/column


COMMENT ON COLUMN myapp_auth_private.auth_user_devices.last_seen_at IS 'Timestamp of the most recent successful auth using this device token';

