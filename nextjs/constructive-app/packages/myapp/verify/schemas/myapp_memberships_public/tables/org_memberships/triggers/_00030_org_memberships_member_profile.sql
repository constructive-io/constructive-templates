-- Verify: schemas/myapp_memberships_public/tables/org_memberships/triggers/_00030_org_memberships_member_profile


SELECT assert_trigger('myapp_memberships_public.org_memberships'::regclass, '_00030_org_memberships_member_profile', 'myapp_memberships_private.org_memberships_member_profile_tg'::regproc, 5);


