-- Verify: schemas/myapp_memberships_public/tables/app_grants/triggers/app_grants_insert_trg


SELECT assert_trigger('myapp_memberships_public.app_grants'::regclass, 'app_grants_insert_trg', 'myapp_memberships_private.app_grants_apply_tg'::regproc, 7);


