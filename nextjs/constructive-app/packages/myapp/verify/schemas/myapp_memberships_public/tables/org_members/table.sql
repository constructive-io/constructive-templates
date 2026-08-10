-- Verify: schemas/myapp_memberships_public/tables/org_members/table


SELECT assert_table('myapp_memberships_public.org_members'::regclass, false, NULL);


