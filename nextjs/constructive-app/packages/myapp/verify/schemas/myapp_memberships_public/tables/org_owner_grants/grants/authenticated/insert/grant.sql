-- Verify: schemas/myapp_memberships_public/tables/org_owner_grants/grants/authenticated/insert/grant


SELECT assert_table_grant('myapp_memberships_public.org_owner_grants'::regclass, 'authenticated', 'INSERT', NULL, true);


