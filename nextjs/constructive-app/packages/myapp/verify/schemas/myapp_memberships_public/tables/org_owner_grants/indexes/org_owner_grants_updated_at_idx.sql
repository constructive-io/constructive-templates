-- Verify: schemas/myapp_memberships_public/tables/org_owner_grants/indexes/org_owner_grants_updated_at_idx


SELECT assert_index('myapp_memberships_public.org_owner_grants_updated_at_idx'::regclass, 'myapp_memberships_public.org_owner_grants'::regclass, false);


