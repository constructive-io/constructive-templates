-- Verify: schemas/myapp_capabilities_public/tables/org_capability_defaults/grants/authenticated/delete/grant


SELECT assert_table_grant('myapp_capabilities_public.org_capability_defaults'::regclass, 'authenticated', 'DELETE', NULL, true);


