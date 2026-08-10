-- Verify: schemas/myapp_memberships_public/tables/org_memberships/policies/auth_upd_ent_mem/policy


SELECT assert_policy('myapp_memberships_public.org_memberships'::regclass, 'auth_upd_ent_mem', 'UPDATE', true, true, false);


