-- Verify: schemas/myapp_capabilities_public/tables/org_capability_defaults/table


SELECT assert_table('myapp_capabilities_public.org_capability_defaults'::regclass, false, NULL);


