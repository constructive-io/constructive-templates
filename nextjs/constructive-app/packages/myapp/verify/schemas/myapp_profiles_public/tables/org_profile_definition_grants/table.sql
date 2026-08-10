-- Verify: schemas/myapp_profiles_public/tables/org_profile_definition_grants/table


SELECT assert_table('myapp_profiles_public.org_profile_definition_grants'::regclass, false, NULL);


