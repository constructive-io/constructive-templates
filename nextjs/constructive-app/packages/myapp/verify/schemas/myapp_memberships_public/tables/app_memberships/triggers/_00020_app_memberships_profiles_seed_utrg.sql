-- Verify: schemas/myapp_memberships_public/tables/app_memberships/triggers/_00020_app_memberships_profiles_seed_utrg


SELECT assert_trigger('myapp_memberships_public.app_memberships'::regclass, '_00020_app_memberships_profiles_seed_utrg', 'myapp_profiles_private.app_memberships_profiles_seed_tg'::regproc, 17);


