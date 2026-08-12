-- Verify: schemas/myapp_limits_public/tables/app_limit_credit_redemptions/policies/auth_sel_own/policy


SELECT assert_policy('myapp_limits_public.app_limit_credit_redemptions'::regclass, 'auth_sel_own', 'SELECT', true, true, false);


