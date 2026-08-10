-- Verify: schemas/myapp_memberships_public/tables/app_owner_grants/triggers/app_owner_grants_insert_trg


SELECT assert_trigger('myapp_memberships_public.app_owner_grants'::regclass, 'app_owner_grants_insert_trg', 'myapp_memberships_private.app_owner_grants_apply_tg'::regproc, 7);


