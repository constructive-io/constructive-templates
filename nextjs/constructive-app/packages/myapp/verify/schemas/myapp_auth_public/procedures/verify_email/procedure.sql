-- Verify: schemas/myapp_auth_public/procedures/verify_email/procedure


SELECT assert_function('myapp_auth_public.verify_email(uuid, text)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


