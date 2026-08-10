-- Verify: schemas/myapp_store_private/procedures/user_secrets_set/procedure


SELECT assert_function('myapp_store_private.user_secrets_set(uuid, text, text, text)'::regprocedure, 'boolean'::regtype, false, false, 'VOLATILE');


