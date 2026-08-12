-- Verify: schemas/myapp_memberships_public/tables/app_memberships/table


SELECT assert_table('myapp_memberships_public.app_memberships'::regclass, false, NULL);


