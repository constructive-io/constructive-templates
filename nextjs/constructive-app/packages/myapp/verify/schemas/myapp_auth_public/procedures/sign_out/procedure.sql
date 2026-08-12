-- Verify: schemas/myapp_auth_public/procedures/sign_out/procedure


SELECT assert_function('myapp_auth_public.sign_out()'::regprocedure, 'void'::regtype, false, true, 'VOLATILE');


