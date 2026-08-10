-- Verify: schemas/myapp_profiles_public/tables/app_profiles/policies/auth_ins_app_mem/policy


SELECT assert_policy('myapp_profiles_public.app_profiles'::regclass, 'auth_ins_app_mem', 'INSERT', true, false, true);


