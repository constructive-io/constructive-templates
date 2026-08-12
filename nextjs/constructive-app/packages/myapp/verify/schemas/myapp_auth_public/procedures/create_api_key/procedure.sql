-- Verify: schemas/myapp_auth_public/procedures/create_api_key/procedure


SELECT assert_function('myapp_auth_public.create_api_key(text, text, text, interval, uuid)'::regprocedure, 'record'::regtype, false, true, 'VOLATILE');


