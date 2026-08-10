-- Verify: schemas/myapp_memberships_public/tables/org_memberships/triggers/_00010_org_memberships_utrg


SELECT assert_trigger('myapp_memberships_public.org_memberships'::regclass, '_00010_org_memberships_utrg', 'myapp_memberships_private.org_memberships_utg'::regproc, 19);


