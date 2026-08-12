-- Verify: schemas/myapp_memberships_public/tables/app_memberships/triggers/_00020_app_memberships_insert_sprt


SELECT assert_trigger('myapp_memberships_public.app_memberships'::regclass, '_00020_app_memberships_insert_sprt', 'myapp_memberships_private.app_memberships_insert_sprt_tg'::regproc, 5);


