-- Verify: schemas/myapp_store_public/procedures/app_internal_secrets_del/procedure


SELECT assert_function('myapp_store_public.app_internal_secrets_del(text, uuid, text)'::regprocedure, 'void'::regtype, false, false, 'VOLATILE');


