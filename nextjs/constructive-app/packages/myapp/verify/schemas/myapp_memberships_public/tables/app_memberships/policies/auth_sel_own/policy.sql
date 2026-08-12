-- Verify: schemas/myapp_memberships_public/tables/app_memberships/policies/auth_sel_own/policy


SELECT assert_policy('myapp_memberships_public.app_memberships'::regclass, 'auth_sel_own', 'SELECT', true, true, false);


