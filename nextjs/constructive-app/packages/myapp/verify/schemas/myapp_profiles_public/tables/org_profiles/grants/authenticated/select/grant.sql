-- Verify: schemas/myapp_profiles_public/tables/org_profiles/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_profiles_public.org_profiles'::regclass, 'authenticated', 'SELECT', NULL, true);


