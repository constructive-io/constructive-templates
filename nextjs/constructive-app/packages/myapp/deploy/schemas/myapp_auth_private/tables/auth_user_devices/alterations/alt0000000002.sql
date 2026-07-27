-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/table


COMMENT ON TABLE myapp_auth_private.auth_user_devices IS 'Tracks recognized and trusted devices per user via persistent opaque device tokens';

