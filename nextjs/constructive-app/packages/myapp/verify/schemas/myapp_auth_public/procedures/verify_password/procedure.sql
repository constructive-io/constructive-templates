-- Verify: schemas/myapp_auth_public/procedures/verify_password/procedure


SELECT assert_function('myapp_auth_public.verify_password(text)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


