-- Verify: schemas/myapp_memberships_public/tables/app_capability_default_grants/indexes/app_capability_default_grants_created_at_idx


SELECT assert_index('myapp_memberships_public.app_capability_default_grants_created_at_idx'::regclass, 'myapp_memberships_public.app_capability_default_grants'::regclass, false);


