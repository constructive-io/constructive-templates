-- Verify: schemas/myapp_capabilities_public/tables/org_capabilities/grants/authenticated/insert/grant


SELECT assert_table_grant('myapp_capabilities_public.org_capabilities'::regclass, 'authenticated', 'INSERT', NULL, true);


