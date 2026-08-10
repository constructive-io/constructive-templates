-- Verify: schemas/myapp_limits_public/tables/app_limit_credit_codes/policies/auth_upd_app_mem/policy


SELECT assert_policy('myapp_limits_public.app_limit_credit_codes'::regclass, 'auth_upd_app_mem', 'UPDATE', true, true, false);


