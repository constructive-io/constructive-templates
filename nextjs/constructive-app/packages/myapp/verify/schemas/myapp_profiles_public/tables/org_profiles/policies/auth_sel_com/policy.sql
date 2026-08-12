-- Verify: schemas/myapp_profiles_public/tables/org_profiles/policies/auth_sel_com/policy


SELECT assert_policy('myapp_profiles_public.org_profiles'::regclass, 'auth_sel_com', 'SELECT', true, true, false);


