-- Verify: schemas/myapp_limits_public/tables/app_limit_credit_redemptions/policies/auth_ins_ent_mem/policy


SELECT assert_policy('myapp_limits_public.app_limit_credit_redemptions'::regclass, 'auth_ins_ent_mem', 'INSERT', true, false, true);


