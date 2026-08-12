-- Verify: schemas/myapp_auth_public/procedures/check_password/procedure


SELECT assert_function('myapp_auth_public.check_password(text)'::regprocedure, 'void'::regtype, false, false, 'VOLATILE');


