-- Verify: schemas/myapp_auth_private/procedures/send_mfa_email_code/procedure


SELECT assert_function('myapp_auth_private.send_mfa_email_code(uuid)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


