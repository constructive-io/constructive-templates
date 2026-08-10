-- Verify: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/grants/authenticated/insert/grant


SELECT assert_table_grant('myapp_memberships_public.app_capability_default_capabilities'::regclass, 'authenticated', 'INSERT', NULL, true);


