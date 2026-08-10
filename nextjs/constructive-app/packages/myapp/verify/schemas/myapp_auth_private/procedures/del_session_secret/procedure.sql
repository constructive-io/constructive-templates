-- Verify: schemas/myapp_auth_private/procedures/del_session_secret/procedure


SELECT assert_function('myapp_auth_private.del_session_secret(uuid, text)'::regprocedure, 'void'::regtype, false, true, 'VOLATILE');


