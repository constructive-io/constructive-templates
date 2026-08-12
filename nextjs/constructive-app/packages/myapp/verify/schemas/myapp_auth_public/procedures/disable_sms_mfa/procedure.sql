-- Verify: schemas/myapp_auth_public/procedures/disable_sms_mfa/procedure


SELECT assert_function('myapp_auth_public.disable_sms_mfa()'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


