-- Verify: schemas/myapp_limits_public/tables/app_limits/policies/auth_ins_app_mem/policy


SELECT assert_policy('myapp_limits_public.app_limits'::regclass, 'auth_ins_app_mem', 'INSERT', true, false, true);


