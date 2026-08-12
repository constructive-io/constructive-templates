-- Verify: schemas/myapp_memberships_public/tables/org_memberships/table


SELECT assert_table('myapp_memberships_public.org_memberships'::regclass, false, NULL);


