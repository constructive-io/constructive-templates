-- Verify: schemas/myapp_memberships_public/tables/app_memberships/triggers/_00000_app_memberships_default_profile_trg


SELECT assert_trigger('myapp_memberships_public.app_memberships'::regclass, '_00000_app_memberships_default_profile_trg', 'myapp_profiles_private.app_memberships_default_profile_tg'::regproc, 7);


