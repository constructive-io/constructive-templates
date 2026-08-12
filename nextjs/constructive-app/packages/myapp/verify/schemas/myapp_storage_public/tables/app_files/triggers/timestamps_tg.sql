-- Verify: schemas/myapp_storage_public/tables/app_files/triggers/timestamps_tg


SELECT assert_trigger('myapp_storage_public.app_files'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


