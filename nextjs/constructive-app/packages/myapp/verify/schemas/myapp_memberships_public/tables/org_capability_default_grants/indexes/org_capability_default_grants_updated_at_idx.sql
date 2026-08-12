-- Verify: schemas/myapp_memberships_public/tables/org_capability_default_grants/indexes/org_capability_default_grants_updated_at_idx


SELECT assert_index('myapp_memberships_public.org_capability_default_grants_updated_at_idx'::regclass, 'myapp_memberships_public.org_capability_default_grants'::regclass, false);


