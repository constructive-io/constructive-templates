-- Verify: schemas/myapp_profiles_public/tables/app_profiles/policies/auth_del_com/policy


SELECT assert_policy('myapp_profiles_public.app_profiles'::regclass, 'auth_del_com', 'DELETE', true, true, false);


