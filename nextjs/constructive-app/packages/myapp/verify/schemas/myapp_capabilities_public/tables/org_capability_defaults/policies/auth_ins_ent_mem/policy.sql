-- Verify: schemas/myapp_capabilities_public/tables/org_capability_defaults/policies/auth_ins_ent_mem/policy


SELECT assert_policy('myapp_capabilities_public.org_capability_defaults'::regclass, 'auth_ins_ent_mem', 'INSERT', true, false, true);


