-- Verify: schemas/myapp_memberships_public/tables/org_memberships/triggers/_00000_org_memberships_default_profile_trg


SELECT assert_trigger('myapp_memberships_public.org_memberships'::regclass, '_00000_org_memberships_default_profile_trg', 'myapp_profiles_private.org_memberships_default_profile_tg'::regproc, 7);


