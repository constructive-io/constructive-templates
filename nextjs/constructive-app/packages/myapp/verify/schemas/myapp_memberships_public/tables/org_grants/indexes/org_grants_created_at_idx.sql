-- Verify: schemas/myapp_memberships_public/tables/org_grants/indexes/org_grants_created_at_idx


SELECT assert_index('myapp_memberships_public.org_grants_created_at_idx'::regclass, 'myapp_memberships_public.org_grants'::regclass, false);


