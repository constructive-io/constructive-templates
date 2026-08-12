-- Verify: schemas/myapp_store_private/tables/user_secrets/triggers/timestamps_tg


SELECT assert_trigger('myapp_store_private.user_secrets'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


