-- Verify: schemas/myapp_app_private/trigger_fns/app_files_inherit_from_parent


SELECT assert_function('myapp_app_private.app_files_inherit_from_parent()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');


