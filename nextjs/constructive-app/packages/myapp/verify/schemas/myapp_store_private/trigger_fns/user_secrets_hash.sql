-- Verify: schemas/myapp_store_private/trigger_fns/user_secrets_hash


SELECT assert_function('myapp_store_private.user_secrets_hash()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');


