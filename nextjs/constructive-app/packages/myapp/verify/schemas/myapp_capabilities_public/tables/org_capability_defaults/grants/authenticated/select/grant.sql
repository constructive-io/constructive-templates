-- Verify: schemas/myapp_capabilities_public/tables/org_capability_defaults/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_capabilities_public.org_capability_defaults'::regclass, 'authenticated', 'SELECT', NULL, true);


