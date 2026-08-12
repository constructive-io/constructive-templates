-- Verify: schemas/myapp_memberships_public/tables/org_memberships/policies/auth_del_delete_own/policy


SELECT assert_policy('myapp_memberships_public.org_memberships'::regclass, 'auth_del_delete_own', 'DELETE', true, true, false);


