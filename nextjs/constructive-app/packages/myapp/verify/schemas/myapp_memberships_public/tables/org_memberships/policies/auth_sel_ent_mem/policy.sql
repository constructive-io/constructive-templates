-- Verify: schemas/myapp_memberships_public/tables/org_memberships/policies/auth_sel_ent_mem/policy


SELECT assert_policy('myapp_memberships_public.org_memberships'::regclass, 'auth_sel_ent_mem', 'SELECT', true, true, false);


