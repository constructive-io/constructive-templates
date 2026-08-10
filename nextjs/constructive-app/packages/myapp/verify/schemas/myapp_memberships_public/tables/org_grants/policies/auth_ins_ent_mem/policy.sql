-- Verify: schemas/myapp_memberships_public/tables/org_grants/policies/auth_ins_ent_mem/policy


SELECT assert_policy('myapp_memberships_public.org_grants'::regclass, 'auth_ins_ent_mem', 'INSERT', true, false, true);


