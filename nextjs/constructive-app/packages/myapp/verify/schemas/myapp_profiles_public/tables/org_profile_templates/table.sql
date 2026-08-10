-- Verify: schemas/myapp_profiles_public/tables/org_profile_templates/table


SELECT assert_table('myapp_profiles_public.org_profile_templates'::regclass, false, NULL);


