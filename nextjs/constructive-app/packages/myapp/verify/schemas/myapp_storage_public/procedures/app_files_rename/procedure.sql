-- Verify: schemas/myapp_storage_public/procedures/app_files_rename/procedure


SELECT assert_function('myapp_storage_public.app_files_rename(pg_catalog.uuid, pg_catalog.text)'::regprocedure, 'myapp_storage_public.app_files'::regtype, false, false, 'VOLATILE');


