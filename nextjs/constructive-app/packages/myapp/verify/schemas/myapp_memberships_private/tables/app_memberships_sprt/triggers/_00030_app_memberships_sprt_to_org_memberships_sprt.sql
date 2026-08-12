-- Verify: schemas/myapp_memberships_private/tables/app_memberships_sprt/triggers/_00030_app_memberships_sprt_to_org_memberships_sprt


SELECT assert_trigger('myapp_memberships_private.app_memberships_sprt'::regclass, '_00030_app_memberships_sprt_to_org_memberships_sprt', 'myapp_memberships_private.app_memberships_sprt_to_org_memberships_sprt_tg'::regproc, 29);


