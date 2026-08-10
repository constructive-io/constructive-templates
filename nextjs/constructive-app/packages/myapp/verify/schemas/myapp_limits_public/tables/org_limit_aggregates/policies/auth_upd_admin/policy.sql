-- Verify: schemas/myapp_limits_public/tables/org_limit_aggregates/policies/auth_upd_admin/policy


SELECT assert_policy('myapp_limits_public.org_limit_aggregates'::regclass, 'auth_upd_admin', 'UPDATE', true, true, false);


