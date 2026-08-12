-- Verify: schemas/myapp_memberships_public/tables/org_memberships/policies/auth_sel_own/policy


SELECT assert_policy('myapp_memberships_public.org_memberships'::regclass, 'auth_sel_own', 'SELECT', true, true, false);


