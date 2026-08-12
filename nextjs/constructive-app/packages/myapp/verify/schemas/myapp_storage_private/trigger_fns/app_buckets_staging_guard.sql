-- Verify: schemas/myapp_storage_private/trigger_fns/app_buckets_staging_guard


SELECT assert_function('myapp_storage_private.app_buckets_staging_guard()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');


