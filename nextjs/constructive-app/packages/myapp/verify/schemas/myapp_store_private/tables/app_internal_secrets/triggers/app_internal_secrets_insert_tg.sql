-- Verify: schemas/myapp_store_private/tables/app_internal_secrets/triggers/app_internal_secrets_insert_tg


SELECT assert_trigger('myapp_store_private.app_internal_secrets'::regclass, 'app_internal_secrets_insert_tg', 'myapp_store_private.app_internal_secrets_hash'::regproc, 7);


