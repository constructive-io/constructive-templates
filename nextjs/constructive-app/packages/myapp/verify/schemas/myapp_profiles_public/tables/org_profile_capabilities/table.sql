-- Verify: schemas/myapp_profiles_public/tables/org_profile_capabilities/table


SELECT assert_table('myapp_profiles_public.org_profile_capabilities'::regclass, false, NULL);


