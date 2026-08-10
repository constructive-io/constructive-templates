-- Verify: schemas/myapp_capabilities_public/tables/app_capabilities/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_capabilities_public.app_capabilities'::regclass, 'authenticated', 'SELECT', NULL, true);


