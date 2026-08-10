-- Verify: schemas/myapp_limits_public/tables/org_limit_defaults/policies/auth_upd_app_mem/policy


SELECT assert_policy('myapp_limits_public.org_limit_defaults'::regclass, 'auth_upd_app_mem', 'UPDATE', true, true, false);


