-- Verify: schemas/myapp_store_private/procedures/user_secrets_verify/procedure


SELECT assert_function('myapp_store_private.user_secrets_verify(uuid, text, text)'::regprocedure, 'boolean'::regtype, false, false, 'STABLE');


