-- Verify: schemas/myapp_memberships_public/tables/org_memberships/triggers/_00020_org_memberships_profiles_seed_itrg


SELECT assert_trigger('myapp_memberships_public.org_memberships'::regclass, '_00020_org_memberships_profiles_seed_itrg', 'myapp_profiles_private.org_memberships_profiles_seed_tg'::regproc, 5);


