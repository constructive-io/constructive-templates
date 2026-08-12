-- Verify: schemas/myapp_auth_private/procedures/authenticate_strict/procedure


SELECT assert_function('myapp_auth_private.authenticate_strict(text)'::regprocedure, 'record'::regtype, true, true, 'VOLATILE');


