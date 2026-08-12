-- Verify: schemas/myapp_store_private/trigger_fns/app_internal_secrets_hash


SELECT assert_function('myapp_store_private.app_internal_secrets_hash()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');


