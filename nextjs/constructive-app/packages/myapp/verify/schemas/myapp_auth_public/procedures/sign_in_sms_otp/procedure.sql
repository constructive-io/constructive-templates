-- Verify: schemas/myapp_auth_public/procedures/sign_in_sms_otp/procedure


SELECT assert_function('myapp_auth_public.sign_in_sms_otp(text, text, text, boolean, text)'::regprocedure, 'record'::regtype, false, true, 'VOLATILE');


