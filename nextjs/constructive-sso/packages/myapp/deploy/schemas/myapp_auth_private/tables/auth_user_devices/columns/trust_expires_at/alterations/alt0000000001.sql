-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/columns/trust_expires_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/columns/trust_expires_at/column


COMMENT ON COLUMN myapp_auth_private.auth_user_devices.trust_expires_at IS 'Timestamp when the device trust expires and MFA will be required again';

