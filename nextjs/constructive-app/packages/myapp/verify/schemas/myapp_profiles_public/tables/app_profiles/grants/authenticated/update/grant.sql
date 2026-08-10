-- Verify: schemas/myapp_profiles_public/tables/app_profiles/grants/authenticated/update/grant


SELECT assert_table_grant('myapp_profiles_public.app_profiles'::regclass, 'authenticated', 'UPDATE', ARRAY['name', 'slug', 'description', 'is_system', 'is_default'], true);


