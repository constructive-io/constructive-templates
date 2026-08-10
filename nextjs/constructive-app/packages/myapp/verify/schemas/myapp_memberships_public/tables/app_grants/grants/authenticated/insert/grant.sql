-- Verify: schemas/myapp_memberships_public/tables/app_grants/grants/authenticated/insert/grant


SELECT assert_table_grant('myapp_memberships_public.app_grants'::regclass, 'authenticated', 'INSERT', NULL, true);


