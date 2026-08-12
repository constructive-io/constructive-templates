-- Verify: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/table


SELECT assert_table('myapp_memberships_public.app_capability_default_capabilities'::regclass, false, NULL);


