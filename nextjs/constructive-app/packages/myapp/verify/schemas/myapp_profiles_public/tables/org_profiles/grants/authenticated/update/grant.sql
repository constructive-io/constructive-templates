-- Verify: schemas/myapp_profiles_public/tables/org_profiles/grants/authenticated/update/grant


SELECT assert_table_grant('myapp_profiles_public.org_profiles'::regclass, 'authenticated', 'UPDATE', ARRAY['name', 'slug', 'description', 'is_system', 'is_default'], true);


