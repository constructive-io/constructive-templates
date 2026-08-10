-- Verify: schemas/myapp_storage_private/procedures/expire_staged_app_files/procedure


SELECT assert_function('myapp_storage_private.expire_staged_app_files()'::regprocedure, 'void'::regtype, false, true, 'VOLATILE');


