-- Verify: schemas/myapp_profiles_public/tables/app_profiles/policies/auth_upd_com/policy


SELECT assert_policy('myapp_profiles_public.app_profiles'::regclass, 'auth_upd_com', 'UPDATE', true, true, false);


