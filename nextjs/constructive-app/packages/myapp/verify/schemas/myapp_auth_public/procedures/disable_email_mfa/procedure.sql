-- Verify: schemas/myapp_auth_public/procedures/disable_email_mfa/procedure


SELECT assert_function('myapp_auth_public.disable_email_mfa()'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


