-- Verify: schemas/myapp_limits_public/tables/org_limit_aggregates/policies/auth_sel_admin/policy


SELECT assert_policy('myapp_limits_public.org_limit_aggregates'::regclass, 'auth_sel_admin', 'SELECT', true, true, false);


