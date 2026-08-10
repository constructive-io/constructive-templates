-- Verify: schemas/myapp_auth_private/tables/app_settings_rate_limit/policies/auth_sel_app_mem/policy


SELECT assert_policy('myapp_auth_private.app_settings_rate_limit'::regclass, 'auth_sel_app_mem', 'SELECT', true, true, false);


