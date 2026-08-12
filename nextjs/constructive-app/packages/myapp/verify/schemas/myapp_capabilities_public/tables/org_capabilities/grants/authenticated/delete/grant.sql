-- Verify: schemas/myapp_capabilities_public/tables/org_capabilities/grants/authenticated/delete/grant


SELECT assert_table_grant('myapp_capabilities_public.org_capabilities'::regclass, 'authenticated', 'DELETE', NULL, true);


