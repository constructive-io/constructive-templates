-- Verify: schemas/myapp_storage_public/tables/app_files/indexes/app_files_bucket_id_idx


SELECT assert_index('myapp_storage_public.app_files_bucket_id_idx'::regclass, 'myapp_storage_public.app_files'::regclass, false);


