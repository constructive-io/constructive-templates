-- Verify: schemas/myapp_memberships_public/tables/app_capability_default_grants/table


SELECT assert_table('myapp_memberships_public.app_capability_default_grants'::regclass, false, NULL);


