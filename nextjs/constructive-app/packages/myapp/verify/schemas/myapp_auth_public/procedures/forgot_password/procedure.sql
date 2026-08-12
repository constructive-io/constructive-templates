-- Verify: schemas/myapp_auth_public/procedures/forgot_password/procedure


SELECT assert_function('myapp_auth_public.forgot_password(email)'::regprocedure, 'void'::regtype, false, true, 'VOLATILE');


