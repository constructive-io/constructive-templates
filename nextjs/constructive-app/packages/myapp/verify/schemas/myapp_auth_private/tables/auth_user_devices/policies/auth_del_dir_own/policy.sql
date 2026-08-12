-- Verify: schemas/myapp_auth_private/tables/auth_user_devices/policies/auth_del_dir_own/policy


SELECT assert_policy('myapp_auth_private.auth_user_devices'::regclass, 'auth_del_dir_own', 'DELETE', true, true, false);


