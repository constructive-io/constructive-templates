-- Verify: schemas/myapp_profiles_public/tables/org_profile_grants/policies/auth_sel_ent_mem/policy


SELECT assert_policy('myapp_profiles_public.org_profile_grants'::regclass, 'auth_sel_ent_mem', 'SELECT', true, true, false);


