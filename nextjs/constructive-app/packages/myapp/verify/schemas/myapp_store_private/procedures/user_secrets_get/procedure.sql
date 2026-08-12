-- Verify: schemas/myapp_store_private/procedures/user_secrets_get/procedure


SELECT assert_function('myapp_store_private.user_secrets_get(uuid, text, text)'::regprocedure, 'text'::regtype, false, false, 'STABLE');


