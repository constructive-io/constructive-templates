-- Verify: schemas/myapp_memberships_public/tables/app_memberships/triggers/_99999_app_memberships_delete_sprt


SELECT assert_trigger('myapp_memberships_public.app_memberships'::regclass, '_99999_app_memberships_delete_sprt', 'myapp_memberships_private.app_memberships_delete_sprt_tg'::regproc, 9);


