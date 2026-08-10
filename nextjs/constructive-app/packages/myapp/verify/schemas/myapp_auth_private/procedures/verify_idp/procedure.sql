-- Verify: schemas/myapp_auth_private/procedures/verify_idp/procedure


SELECT assert_function('myapp_auth_private.verify_idp(text, text, jsonb)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


