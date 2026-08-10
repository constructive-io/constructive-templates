-- Verify: schemas/myapp_profiles_public/tables/app_profile_capabilities/table


SELECT assert_table('myapp_profiles_public.app_profile_capabilities'::regclass, false, NULL);


