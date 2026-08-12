-- Verify: schemas/myapp_capabilities_public/tables/org_capabilities/table


SELECT assert_table('myapp_capabilities_public.org_capabilities'::regclass, false, NULL);


