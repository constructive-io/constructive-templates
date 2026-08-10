-- Verify: schemas/myapp_auth_private/procedures/send_sms_otp/procedure


SELECT assert_function('myapp_auth_private.send_sms_otp(text)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


