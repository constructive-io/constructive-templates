-- Verify: schemas/myapp_storage_public/tables/app_files/triggers/app_files_immutable_fields_tg


SELECT assert_trigger('myapp_storage_public.app_files'::regclass, 'app_files_immutable_fields_tg', 'myapp_app_private.app_files_immutable_fields'::regproc, 19);


