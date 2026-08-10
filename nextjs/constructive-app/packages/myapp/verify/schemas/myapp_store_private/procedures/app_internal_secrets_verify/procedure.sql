-- Verify: schemas/myapp_store_private/procedures/app_internal_secrets_verify/procedure


SELECT assert_function('myapp_store_private.app_internal_secrets_verify(text, text, uuid)'::regprocedure, 'boolean'::regtype, false, false, 'STABLE');


