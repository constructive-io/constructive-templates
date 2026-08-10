-- Verify: schemas/myapp_memberships_public/tables/org_owner_grants/table


SELECT assert_table('myapp_memberships_public.org_owner_grants'::regclass, false, NULL);


