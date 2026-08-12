-- Verify: schemas/myapp_profiles_public/tables/org_profile_capabilities/grants/authenticated/insert/grant


SELECT assert_table_grant('myapp_profiles_public.org_profile_capabilities'::regclass, 'authenticated', 'INSERT', NULL, true);


