-- Verify: schemas/myapp_memberships_public/tables/org_admin_grants/table


SELECT assert_table('myapp_memberships_public.org_admin_grants'::regclass, false, NULL);


