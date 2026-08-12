-- Verify: schemas/myapp_profiles_public/tables/org_profiles/table


SELECT assert_table('myapp_profiles_public.org_profiles'::regclass, false, NULL);


