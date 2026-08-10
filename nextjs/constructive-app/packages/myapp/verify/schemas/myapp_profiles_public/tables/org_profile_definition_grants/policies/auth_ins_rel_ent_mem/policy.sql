-- Verify: schemas/myapp_profiles_public/tables/org_profile_definition_grants/policies/auth_ins_rel_ent_mem/policy


SELECT assert_policy('myapp_profiles_public.org_profile_definition_grants'::regclass, 'auth_ins_rel_ent_mem', 'INSERT', true, false, true);


