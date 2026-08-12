-- Verify: schemas/myapp_auth_private/procedures/authenticate/procedure


SELECT assert_function('myapp_auth_private.authenticate(text)'::regprocedure, 'record'::regtype, true, true, 'VOLATILE');


