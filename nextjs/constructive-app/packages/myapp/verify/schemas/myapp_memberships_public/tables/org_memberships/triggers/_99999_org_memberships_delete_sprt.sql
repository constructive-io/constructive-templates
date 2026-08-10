-- Verify: schemas/myapp_memberships_public/tables/org_memberships/triggers/_99999_org_memberships_delete_sprt


SELECT assert_trigger('myapp_memberships_public.org_memberships'::regclass, '_99999_org_memberships_delete_sprt', 'myapp_memberships_private.org_memberships_delete_sprt_tg'::regproc, 9);


