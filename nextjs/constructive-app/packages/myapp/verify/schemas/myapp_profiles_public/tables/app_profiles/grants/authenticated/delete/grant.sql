-- Verify: schemas/myapp_profiles_public/tables/app_profiles/grants/authenticated/delete/grant


SELECT assert_table_grant('myapp_profiles_public.app_profiles'::regclass, 'authenticated', 'DELETE', NULL, true);


