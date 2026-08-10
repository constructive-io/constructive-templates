-- Verify: schemas/myapp_auth_private/tables/auth_user_devices/indexes/auth_user_devices_updated_at_idx


SELECT assert_index('myapp_auth_private.auth_user_devices_updated_at_idx'::regclass, 'myapp_auth_private.auth_user_devices'::regclass, false);


