-- Verify: schemas/myapp_auth_private/tables/auth_user_devices/policies/auth_sel_dir_own/policy


SELECT assert_policy('myapp_auth_private.auth_user_devices'::regclass, 'auth_sel_dir_own', 'SELECT', true, true, false);


