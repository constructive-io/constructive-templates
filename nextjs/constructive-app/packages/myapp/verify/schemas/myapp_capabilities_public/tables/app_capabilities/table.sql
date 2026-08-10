-- Verify: schemas/myapp_capabilities_public/tables/app_capabilities/table


SELECT assert_table('myapp_capabilities_public.app_capabilities'::regclass, false, NULL);


