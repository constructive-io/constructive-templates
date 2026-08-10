-- Verify: schemas/myapp_limits_public/tables/app_limit_events/policies/auth_sel_app_mem/policy


SELECT assert_policy('myapp_limits_public.app_limit_events'::regclass, 'auth_sel_app_mem', 'SELECT', true, true, false);


