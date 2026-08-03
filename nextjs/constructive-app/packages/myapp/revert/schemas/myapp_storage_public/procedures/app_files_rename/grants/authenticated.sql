-- Revert: schemas/myapp_storage_public/procedures/app_files_rename/grants/authenticated


REVOKE EXECUTE ON FUNCTION myapp_storage_public.app_files_rename FROM authenticated;


