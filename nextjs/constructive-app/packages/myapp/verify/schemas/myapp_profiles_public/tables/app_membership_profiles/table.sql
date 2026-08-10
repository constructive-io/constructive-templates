-- Verify: schemas/myapp_profiles_public/tables/app_membership_profiles/table


SELECT assert_table('myapp_profiles_public.app_membership_profiles'::regclass, false, NULL);


