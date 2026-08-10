-- Verify: schemas/myapp_profiles_public/tables/org_profiles/policies/auth_ins_ent_mem/policy


SELECT assert_policy('myapp_profiles_public.org_profiles'::regclass, 'auth_ins_ent_mem', 'INSERT', true, false, true);


