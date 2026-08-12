-- Verify: schemas/myapp_memberships_public/tables/org_memberships/policies/auth_del_ent_mem/policy


SELECT assert_policy('myapp_memberships_public.org_memberships'::regclass, 'auth_del_ent_mem', 'DELETE', true, true, false);


