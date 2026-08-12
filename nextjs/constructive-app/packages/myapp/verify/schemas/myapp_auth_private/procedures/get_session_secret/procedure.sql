-- Verify: schemas/myapp_auth_private/procedures/get_session_secret/procedure


SELECT assert_function('myapp_auth_private.get_session_secret(uuid, text)'::regprocedure, 'text'::regtype, false, true, 'STABLE');


