-- Verify: schemas/myapp_auth_private/procedures/request_magic_link/procedure


SELECT assert_function('myapp_auth_private.request_magic_link(text)'::regprocedure, 'record'::regtype, false, true, 'VOLATILE');


