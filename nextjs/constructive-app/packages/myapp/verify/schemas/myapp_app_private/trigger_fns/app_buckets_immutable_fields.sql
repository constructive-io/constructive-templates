-- Verify: schemas/myapp_app_private/trigger_fns/app_buckets_immutable_fields


SELECT assert_function('myapp_app_private.app_buckets_immutable_fields()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');


