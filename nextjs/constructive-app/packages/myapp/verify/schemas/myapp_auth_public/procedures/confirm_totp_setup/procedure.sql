-- Verify: schemas/myapp_auth_public/procedures/confirm_totp_setup/procedure


SELECT assert_function('myapp_auth_public.confirm_totp_setup(text)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


