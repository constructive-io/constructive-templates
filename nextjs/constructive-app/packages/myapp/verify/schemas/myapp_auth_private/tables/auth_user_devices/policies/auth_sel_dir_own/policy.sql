-- Verify: schemas/myapp_auth_private/tables/auth_user_devices/policies/auth_sel_dir_own/policy


SELECT verify_policy('auth_sel_dir_own', 'myapp_auth_private.auth_user_devices');


