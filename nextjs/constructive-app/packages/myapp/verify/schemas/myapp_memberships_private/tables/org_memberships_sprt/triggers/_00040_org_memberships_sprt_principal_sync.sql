-- Verify: schemas/myapp_memberships_private/tables/org_memberships_sprt/triggers/_00040_org_memberships_sprt_principal_sync


SELECT assert_trigger('myapp_memberships_private.org_memberships_sprt'::regclass, '_00040_org_memberships_sprt_principal_sync', 'myapp_auth_private.org_memberships_sprt_principal_sync_tg'::regproc, 29);


