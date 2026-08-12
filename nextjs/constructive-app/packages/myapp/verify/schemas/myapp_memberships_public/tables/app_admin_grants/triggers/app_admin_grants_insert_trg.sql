-- Verify: schemas/myapp_memberships_public/tables/app_admin_grants/triggers/app_admin_grants_insert_trg


SELECT assert_trigger('myapp_memberships_public.app_admin_grants'::regclass, 'app_admin_grants_insert_trg', 'myapp_memberships_private.app_admin_grants_apply_tg'::regproc, 7);


