-- Verify: schemas/myapp_store_public/procedures/app_internal_secrets_rotate/procedure


SELECT assert_function('myapp_store_public.app_internal_secrets_rotate(text, text, uuid, text, text)'::regprocedure, 'boolean'::regtype, false, false, 'VOLATILE');


