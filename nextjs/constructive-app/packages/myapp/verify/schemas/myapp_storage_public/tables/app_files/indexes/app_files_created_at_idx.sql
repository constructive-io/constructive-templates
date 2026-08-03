-- Verify: schemas/myapp_storage_public/tables/app_files/indexes/app_files_created_at_idx


SELECT verify_index('myapp_storage_public.app_files', 'app_files_created_at_idx');


