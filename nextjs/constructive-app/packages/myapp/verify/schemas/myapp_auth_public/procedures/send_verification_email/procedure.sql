-- Verify: schemas/myapp_auth_public/procedures/send_verification_email/procedure


SELECT assert_function('myapp_auth_public.send_verification_email(email)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


