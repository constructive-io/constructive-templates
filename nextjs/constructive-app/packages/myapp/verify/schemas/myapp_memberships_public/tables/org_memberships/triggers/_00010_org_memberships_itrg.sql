-- Verify: schemas/myapp_memberships_public/tables/org_memberships/triggers/_00010_org_memberships_itrg


SELECT assert_trigger('myapp_memberships_public.org_memberships'::regclass, '_00010_org_memberships_itrg', 'myapp_memberships_private.org_memberships_itg'::regproc, 7);


