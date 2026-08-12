-- Verify: schemas/myapp_limits_public/tables/org_limit_caps/policies/auth_del_admin/policy


SELECT assert_policy('myapp_limits_public.org_limit_caps'::regclass, 'auth_del_admin', 'DELETE', true, true, false);


