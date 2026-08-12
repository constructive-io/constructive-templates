-- Verify: schemas/myapp_memberships_public/tables/app_memberships/indexes/app_memberships_profile_id_idx


SELECT assert_index('myapp_memberships_public.app_memberships_profile_id_idx'::regclass, 'myapp_memberships_public.app_memberships'::regclass, false);


