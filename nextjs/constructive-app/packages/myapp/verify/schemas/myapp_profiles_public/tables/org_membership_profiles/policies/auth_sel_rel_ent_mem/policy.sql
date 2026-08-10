-- Verify: schemas/myapp_profiles_public/tables/org_membership_profiles/policies/auth_sel_rel_ent_mem/policy


SELECT assert_policy('myapp_profiles_public.org_membership_profiles'::regclass, 'auth_sel_rel_ent_mem', 'SELECT', true, true, false);


