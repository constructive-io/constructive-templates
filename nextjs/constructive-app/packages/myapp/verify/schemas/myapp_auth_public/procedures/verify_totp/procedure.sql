-- Verify: schemas/myapp_auth_public/procedures/verify_totp/procedure


SELECT assert_function('myapp_auth_public.verify_totp(text)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


