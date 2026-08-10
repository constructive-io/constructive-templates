-- Verify: schemas/myapp_profiles_public/tables/org_profile_capabilities/policies/auth_ins_rel_ent_mem/policy


SELECT assert_policy('myapp_profiles_public.org_profile_capabilities'::regclass, 'auth_ins_rel_ent_mem', 'INSERT', true, false, true);


