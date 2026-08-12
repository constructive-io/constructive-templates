-- Verify: schemas/myapp_memberships_public/tables/app_memberships/triggers/_00010_app_memberships_utrg


SELECT assert_trigger('myapp_memberships_public.app_memberships'::regclass, '_00010_app_memberships_utrg', 'myapp_memberships_private.app_memberships_utg'::regproc, 19);


