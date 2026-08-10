-- Verify: schemas/myapp_app_private/trigger_fns/app_files_immutable_fields


SELECT assert_function('myapp_app_private.app_files_immutable_fields()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');


