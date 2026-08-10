-- Verify: schemas/myapp_memberships_public/tables/app_memberships/indexes/app_memberships_updated_at_idx


SELECT assert_index('myapp_memberships_public.app_memberships_updated_at_idx'::regclass, 'myapp_memberships_public.app_memberships'::regclass, false);


