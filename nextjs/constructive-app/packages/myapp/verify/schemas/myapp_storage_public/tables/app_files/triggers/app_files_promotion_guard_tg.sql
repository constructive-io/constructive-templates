-- Verify: schemas/myapp_storage_public/tables/app_files/triggers/app_files_promotion_guard_tg


SELECT assert_trigger('myapp_storage_public.app_files'::regclass, 'app_files_promotion_guard_tg', 'myapp_storage_private.app_files_promotion_guard'::regproc, 19);


