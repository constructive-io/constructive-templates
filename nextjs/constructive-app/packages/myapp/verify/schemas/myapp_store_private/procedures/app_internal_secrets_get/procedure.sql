-- Verify: schemas/myapp_store_private/procedures/app_internal_secrets_get/procedure


SELECT assert_function('myapp_store_private.app_internal_secrets_get(text, uuid, text, text)'::regprocedure, 'text'::regtype, false, false, 'STABLE');


