-- Verify: schemas/myapp_storage_private/trigger_fns/app_files_promotion_guard


SELECT assert_function('myapp_storage_private.app_files_promotion_guard()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


