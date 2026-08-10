-- Verify: schemas/myapp_storage_public/procedures/app_files_file_path/procedure


SELECT assert_function('myapp_storage_public.app_files_file_path(myapp_storage_public.app_files)'::regprocedure, 'text'::regtype, false, false, 'STABLE');


