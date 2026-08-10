-- Verify: schemas/myapp_capabilities_public/tables/app_capability_defaults/table


SELECT assert_table('myapp_capabilities_public.app_capability_defaults'::regclass, false, NULL);


