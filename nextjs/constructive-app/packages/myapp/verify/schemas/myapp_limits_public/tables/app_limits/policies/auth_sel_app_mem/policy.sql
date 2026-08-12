-- Verify: schemas/myapp_limits_public/tables/app_limits/policies/auth_sel_app_mem/policy


SELECT assert_policy('myapp_limits_public.app_limits'::regclass, 'auth_sel_app_mem', 'SELECT', true, true, false);


