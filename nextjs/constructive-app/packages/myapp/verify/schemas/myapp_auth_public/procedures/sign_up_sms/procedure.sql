-- Verify: schemas/myapp_auth_public/procedures/sign_up_sms/procedure


SELECT assert_function('myapp_auth_public.sign_up_sms(text, text, text, boolean, text)'::regprocedure, 'record'::regtype, false, true, 'VOLATILE');


