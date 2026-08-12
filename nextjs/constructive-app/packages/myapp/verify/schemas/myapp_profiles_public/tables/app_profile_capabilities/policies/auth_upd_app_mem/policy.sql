-- Verify: schemas/myapp_profiles_public/tables/app_profile_capabilities/policies/auth_upd_app_mem/policy


SELECT assert_policy('myapp_profiles_public.app_profile_capabilities'::regclass, 'auth_upd_app_mem', 'UPDATE', true, true, false);


