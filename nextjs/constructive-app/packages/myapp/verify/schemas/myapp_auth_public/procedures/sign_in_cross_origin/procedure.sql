-- Verify: schemas/myapp_auth_public/procedures/sign_in_cross_origin/procedure


SELECT assert_function('myapp_auth_public.sign_in_cross_origin(text, text)'::regprocedure, 'record'::regtype, false, true, 'VOLATILE');


