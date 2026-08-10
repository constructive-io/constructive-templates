-- Verify: schemas/myapp_memberships_public/tables/app_grants/table


SELECT assert_table('myapp_memberships_public.app_grants'::regclass, false, NULL);


