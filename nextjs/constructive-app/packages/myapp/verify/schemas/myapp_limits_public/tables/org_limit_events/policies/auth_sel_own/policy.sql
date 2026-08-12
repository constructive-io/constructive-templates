-- Verify: schemas/myapp_limits_public/tables/org_limit_events/policies/auth_sel_own/policy


SELECT assert_policy('myapp_limits_public.org_limit_events'::regclass, 'auth_sel_own', 'SELECT', true, true, false);


