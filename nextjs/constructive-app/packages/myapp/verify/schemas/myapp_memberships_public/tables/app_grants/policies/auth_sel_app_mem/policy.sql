-- Verify: schemas/myapp_memberships_public/tables/app_grants/policies/auth_sel_app_mem/policy


SELECT assert_policy('myapp_memberships_public.app_grants'::regclass, 'auth_sel_app_mem', 'SELECT', true, true, false);


