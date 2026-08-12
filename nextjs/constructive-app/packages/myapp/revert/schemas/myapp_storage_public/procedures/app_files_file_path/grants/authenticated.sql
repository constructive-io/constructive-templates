-- Revert: schemas/myapp_storage_public/procedures/app_files_file_path/grants/authenticated


REVOKE EXECUTE ON FUNCTION myapp_storage_public.app_files_file_path FROM authenticated;


