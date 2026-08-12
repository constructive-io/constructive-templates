-- Verify: schemas/myapp_auth_public/procedures/disable_totp/procedure


SELECT assert_function('myapp_auth_public.disable_totp(text)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


