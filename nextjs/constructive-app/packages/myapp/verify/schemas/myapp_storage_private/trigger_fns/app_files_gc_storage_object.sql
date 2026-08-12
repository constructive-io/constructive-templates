-- Verify: schemas/myapp_storage_private/trigger_fns/app_files_gc_storage_object


SELECT assert_function('myapp_storage_private.app_files_gc_storage_object()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');


