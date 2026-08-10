-- Verify: schemas/myapp_auth_private/tables/app_settings_auth/policies/auth_sel_app_mem/policy


SELECT assert_policy('myapp_auth_private.app_settings_auth'::regclass, 'auth_sel_app_mem', 'SELECT', true, true, false);


