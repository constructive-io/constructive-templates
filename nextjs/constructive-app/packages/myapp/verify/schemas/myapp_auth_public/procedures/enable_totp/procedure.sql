-- Verify: schemas/myapp_auth_public/procedures/enable_totp/procedure


SELECT assert_function('myapp_auth_public.enable_totp()'::regprocedure, 'text'::regtype, false, true, 'VOLATILE');


