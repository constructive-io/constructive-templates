-- Verify: schemas/myapp_storage_public/tables/app_files/indexes/app_files_updated_at_idx


SELECT assert_index('myapp_storage_public.app_files_updated_at_idx'::regclass, 'myapp_storage_public.app_files'::regclass, false);


