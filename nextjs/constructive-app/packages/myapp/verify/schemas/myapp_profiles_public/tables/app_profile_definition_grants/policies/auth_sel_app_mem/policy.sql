-- Verify: schemas/myapp_profiles_public/tables/app_profile_definition_grants/policies/auth_sel_app_mem/policy


SELECT assert_policy('myapp_profiles_public.app_profile_definition_grants'::regclass, 'auth_sel_app_mem', 'SELECT', true, true, false);


