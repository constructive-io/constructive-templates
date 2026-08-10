-- Verify: schemas/myapp_auth_private/procedures/sign_up_identity/procedure


SELECT assert_function('myapp_auth_private.sign_up_identity(text, text, text, jsonb, text, boolean, text)'::regprocedure, 'record'::regtype, false, true, 'VOLATILE');


