-- Verify: schemas/myapp_memberships_public/tables/org_memberships/triggers/_00015_org_memberships_profile_sync_itrg


SELECT assert_trigger('myapp_memberships_public.org_memberships'::regclass, '_00015_org_memberships_profile_sync_itrg', 'myapp_profiles_private.org_memberships_profile_sync_tg'::regproc, 7);


