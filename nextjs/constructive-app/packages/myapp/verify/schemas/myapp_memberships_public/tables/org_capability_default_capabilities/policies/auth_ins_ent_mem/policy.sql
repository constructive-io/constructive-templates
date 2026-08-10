-- Verify: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/policies/auth_ins_ent_mem/policy


SELECT assert_policy('myapp_memberships_public.org_capability_default_capabilities'::regclass, 'auth_ins_ent_mem', 'INSERT', true, false, true);


