-- Verify: schemas/myapp_store_private/procedures/user_secrets_del/procedure


SELECT assert_function('myapp_store_private.user_secrets_del(uuid, text)'::regprocedure, 'void'::regtype, false, true, 'VOLATILE');


