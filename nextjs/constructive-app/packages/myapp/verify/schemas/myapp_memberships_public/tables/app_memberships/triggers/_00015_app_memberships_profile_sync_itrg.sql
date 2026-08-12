-- Verify: schemas/myapp_memberships_public/tables/app_memberships/triggers/_00015_app_memberships_profile_sync_itrg


SELECT assert_trigger('myapp_memberships_public.app_memberships'::regclass, '_00015_app_memberships_profile_sync_itrg', 'myapp_profiles_private.app_memberships_profile_sync_tg'::regproc, 7);


