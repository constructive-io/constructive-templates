-- Verify: schemas/myapp_auth_private/procedures/sign_in_identity/procedure


SELECT assert_function('myapp_auth_private.sign_in_identity(text, text, jsonb, text, text, boolean, text)'::regprocedure, 'record'::regtype, false, true, 'VOLATILE');


