-- Verify: schemas/myapp_memberships_public/tables/org_memberships/triggers/_99990_org_memberships_owners_chk


SELECT assert_trigger('myapp_memberships_public.org_memberships'::regclass, '_99990_org_memberships_owners_chk', 'myapp_memberships_private.org_memberships_dtg'::regproc, 11);


