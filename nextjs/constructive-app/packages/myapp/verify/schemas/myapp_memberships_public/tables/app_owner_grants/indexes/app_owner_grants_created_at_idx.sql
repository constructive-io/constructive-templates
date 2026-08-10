-- Verify: schemas/myapp_memberships_public/tables/app_owner_grants/indexes/app_owner_grants_created_at_idx


SELECT assert_index('myapp_memberships_public.app_owner_grants_created_at_idx'::regclass, 'myapp_memberships_public.app_owner_grants'::regclass, false);


