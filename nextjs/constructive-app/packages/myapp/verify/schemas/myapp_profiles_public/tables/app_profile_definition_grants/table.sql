-- Verify: schemas/myapp_profiles_public/tables/app_profile_definition_grants/table


SELECT assert_table('myapp_profiles_public.app_profile_definition_grants'::regclass, false, NULL);


