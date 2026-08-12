-- Verify: schemas/myapp_profiles_public/tables/app_profile_grants/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_profiles_public.app_profile_grants'::regclass, 'authenticated', 'SELECT', NULL, true);


