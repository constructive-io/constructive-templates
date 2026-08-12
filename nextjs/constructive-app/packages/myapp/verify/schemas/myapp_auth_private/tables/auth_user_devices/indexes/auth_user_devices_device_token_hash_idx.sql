-- Verify: schemas/myapp_auth_private/tables/auth_user_devices/indexes/auth_user_devices_device_token_hash_idx


SELECT assert_index('myapp_auth_private.auth_user_devices_device_token_hash_idx'::regclass, 'myapp_auth_private.auth_user_devices'::regclass, false);


