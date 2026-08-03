-- Deploy: schemas/myapp_storage_public/procedures/app_files_rename/grants/authenticated
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/procedures/app_files_rename/procedure


GRANT EXECUTE ON FUNCTION myapp_storage_public.app_files_rename TO authenticated;

