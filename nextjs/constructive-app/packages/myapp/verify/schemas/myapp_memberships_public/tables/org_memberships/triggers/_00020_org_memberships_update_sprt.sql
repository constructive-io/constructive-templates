-- Verify: schemas/myapp_memberships_public/tables/org_memberships/triggers/_00020_org_memberships_update_sprt


SELECT assert_trigger('myapp_memberships_public.org_memberships'::regclass, '_00020_org_memberships_update_sprt', 'myapp_memberships_private.org_memberships_update_sprt_tg'::regproc, 17);


