-- Verify: schemas/myapp_auth_public/procedures/enable_email_mfa/procedure


SELECT assert_function('myapp_auth_public.enable_email_mfa()'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


