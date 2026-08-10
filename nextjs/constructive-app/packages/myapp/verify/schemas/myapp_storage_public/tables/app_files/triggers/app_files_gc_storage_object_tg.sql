-- Verify: schemas/myapp_storage_public/tables/app_files/triggers/app_files_gc_storage_object_tg


SELECT assert_trigger('myapp_storage_public.app_files'::regclass, 'app_files_gc_storage_object_tg', 'myapp_storage_private.app_files_gc_storage_object'::regproc, 9);


