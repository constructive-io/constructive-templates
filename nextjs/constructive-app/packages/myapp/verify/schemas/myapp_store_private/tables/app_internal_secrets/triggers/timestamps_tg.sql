-- Verify: schemas/myapp_store_private/tables/app_internal_secrets/triggers/timestamps_tg


SELECT assert_trigger('myapp_store_private.app_internal_secrets'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


