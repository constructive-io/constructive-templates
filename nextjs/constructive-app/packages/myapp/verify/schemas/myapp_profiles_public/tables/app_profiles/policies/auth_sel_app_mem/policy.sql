-- Verify: schemas/myapp_profiles_public/tables/app_profiles/policies/auth_sel_app_mem/policy


SELECT assert_policy('myapp_profiles_public.app_profiles'::regclass, 'auth_sel_app_mem', 'SELECT', true, true, false);


