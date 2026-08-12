-- Verify: schemas/myapp_auth_public/procedures/sign_up/procedure


SELECT assert_function('myapp_auth_public.sign_up(text, text, boolean, text, text, text)'::regprocedure, 'record'::regtype, false, true, 'VOLATILE');


