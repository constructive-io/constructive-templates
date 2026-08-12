-- Verify: schemas/myapp_storage_private/procedures/app_files_staged_expiry_candidates/procedure


SELECT assert_function('myapp_storage_private.app_files_staged_expiry_candidates()'::regprocedure, 'record'::regtype, true, true, 'STABLE');


