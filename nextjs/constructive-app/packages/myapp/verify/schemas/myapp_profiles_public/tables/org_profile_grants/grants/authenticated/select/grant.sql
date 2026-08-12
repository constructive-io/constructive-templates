-- Verify: schemas/myapp_profiles_public/tables/org_profile_grants/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_profiles_public.org_profile_grants'::regclass, 'authenticated', 'SELECT', NULL, true);


