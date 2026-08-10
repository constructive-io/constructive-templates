-- Verify: schemas/myapp_memberships_public/tables/org_capability_default_grants/grants/authenticated/insert/grant


SELECT assert_table_grant('myapp_memberships_public.org_capability_default_grants'::regclass, 'authenticated', 'INSERT', NULL, true);


