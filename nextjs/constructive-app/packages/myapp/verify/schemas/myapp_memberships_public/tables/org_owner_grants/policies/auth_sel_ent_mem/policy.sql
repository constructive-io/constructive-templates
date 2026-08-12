-- Verify: schemas/myapp_memberships_public/tables/org_owner_grants/policies/auth_sel_ent_mem/policy


SELECT assert_policy('myapp_memberships_public.org_owner_grants'::regclass, 'auth_sel_ent_mem', 'SELECT', true, true, false);


