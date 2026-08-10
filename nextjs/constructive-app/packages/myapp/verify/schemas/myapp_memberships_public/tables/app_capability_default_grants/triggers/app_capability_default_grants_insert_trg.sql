-- Verify: schemas/myapp_memberships_public/tables/app_capability_default_grants/triggers/app_capability_default_grants_insert_trg


SELECT assert_trigger('myapp_memberships_public.app_capability_default_grants'::regclass, 'app_capability_default_grants_insert_trg', 'myapp_memberships_private.app_capability_default_grants_apply_tg'::regproc, 7);


