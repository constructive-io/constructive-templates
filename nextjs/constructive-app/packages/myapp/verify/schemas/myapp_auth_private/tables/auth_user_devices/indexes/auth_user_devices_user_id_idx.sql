-- Verify: schemas/myapp_auth_private/tables/auth_user_devices/indexes/auth_user_devices_user_id_idx


SELECT assert_index('myapp_auth_private.auth_user_devices_user_id_idx'::regclass, 'myapp_auth_private.auth_user_devices'::regclass, false);


