-- Verify: schemas/myapp_profiles_public/tables/app_membership_profiles/policies/auth_sel_own/policy


SELECT assert_policy('myapp_profiles_public.app_membership_profiles'::regclass, 'auth_sel_own', 'SELECT', true, true, false);


