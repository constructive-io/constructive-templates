-- Verify: schemas/myapp_auth_public/procedures/send_account_deletion_email/procedure


SELECT assert_function('myapp_auth_public.send_account_deletion_email()'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


