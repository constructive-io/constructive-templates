-- Verify: schemas/myapp_auth_public/procedures/extend_token_expires/procedure


SELECT assert_function('myapp_auth_public.extend_token_expires(interval)'::regprocedure, 'record'::regtype, true, true, 'VOLATILE');


