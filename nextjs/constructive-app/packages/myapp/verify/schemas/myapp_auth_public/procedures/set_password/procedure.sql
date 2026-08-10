-- Verify: schemas/myapp_auth_public/procedures/set_password/procedure


SELECT assert_function('myapp_auth_public.set_password(text, text)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


