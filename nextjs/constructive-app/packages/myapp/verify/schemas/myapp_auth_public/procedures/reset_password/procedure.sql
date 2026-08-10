-- Verify: schemas/myapp_auth_public/procedures/reset_password/procedure


SELECT assert_function('myapp_auth_public.reset_password(uuid, text, text)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


