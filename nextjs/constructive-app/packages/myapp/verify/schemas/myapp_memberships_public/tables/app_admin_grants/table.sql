-- Verify: schemas/myapp_memberships_public/tables/app_admin_grants/table


SELECT assert_table('myapp_memberships_public.app_admin_grants'::regclass, false, NULL);


