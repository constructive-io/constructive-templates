-- Verify: schemas/myapp_memberships_public/tables/org_memberships/indexes/org_memberships_created_by_idx


SELECT assert_index('myapp_memberships_public.org_memberships_created_by_idx'::regclass, 'myapp_memberships_public.org_memberships'::regclass, false);


