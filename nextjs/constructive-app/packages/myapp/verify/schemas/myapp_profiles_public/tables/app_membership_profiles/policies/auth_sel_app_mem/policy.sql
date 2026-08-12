-- Verify: schemas/myapp_profiles_public/tables/app_membership_profiles/policies/auth_sel_app_mem/policy


SELECT assert_policy('myapp_profiles_public.app_membership_profiles'::regclass, 'auth_sel_app_mem', 'SELECT', true, true, false);


