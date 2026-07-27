-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/columns/device_token_hash/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/columns/device_token_hash/column


COMMENT ON COLUMN myapp_auth_private.auth_user_devices.device_token_hash IS E'SHA-256 hash of the persistent device token (stored in secure cookie on client)';

