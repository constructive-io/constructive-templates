-- Verify: schemas/myapp_memberships_public/tables/org_capability_default_grants/table


SELECT assert_table('myapp_memberships_public.org_capability_default_grants'::regclass, false, NULL);


