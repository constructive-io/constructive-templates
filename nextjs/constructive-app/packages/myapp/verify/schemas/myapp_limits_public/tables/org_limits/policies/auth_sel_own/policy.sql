-- Verify: schemas/myapp_limits_public/tables/org_limits/policies/auth_sel_own/policy


SELECT assert_policy('myapp_limits_public.org_limits'::regclass, 'auth_sel_own', 'SELECT', true, true, false);


