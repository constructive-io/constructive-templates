-- Verify: schemas/myapp_profiles_public/tables/app_profile_capabilities/policies/auth_ins_app_mem/policy


SELECT assert_policy('myapp_profiles_public.app_profile_capabilities'::regclass, 'auth_ins_app_mem', 'INSERT', true, false, true);


