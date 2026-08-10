-- Verify: schemas/myapp_limits_public/tables/app_limit_credit_code_items/policies/auth_ins_app_mem/policy


SELECT assert_policy('myapp_limits_public.app_limit_credit_code_items'::regclass, 'auth_ins_app_mem', 'INSERT', true, false, true);


