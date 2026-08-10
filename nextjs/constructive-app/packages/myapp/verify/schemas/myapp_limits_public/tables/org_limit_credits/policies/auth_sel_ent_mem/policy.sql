-- Verify: schemas/myapp_limits_public/tables/org_limit_credits/policies/auth_sel_ent_mem/policy


SELECT assert_policy('myapp_limits_public.org_limit_credits'::regclass, 'auth_sel_ent_mem', 'SELECT', true, true, false);


