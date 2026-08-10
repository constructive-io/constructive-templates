-- Verify: schemas/myapp_profiles_public/tables/app_membership_profiles/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_profiles_public.app_membership_profiles'::regclass, 'authenticated', 'SELECT', NULL, true);


