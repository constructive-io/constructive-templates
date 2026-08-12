-- Verify: schemas/myapp_memberships_public/tables/app_owner_grants/table


SELECT assert_table('myapp_memberships_public.app_owner_grants'::regclass, false, NULL);


