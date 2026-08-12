-- Verify: schemas/myapp_store_private/tables/user_secrets/triggers/user_secrets_update_tg


SELECT assert_trigger('myapp_store_private.user_secrets'::regclass, 'user_secrets_update_tg', 'myapp_store_private.user_secrets_hash'::regproc, 19);


