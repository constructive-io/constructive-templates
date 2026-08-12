-- Verify: schemas/myapp_auth_private/procedures/set_session_secret/procedure


SELECT assert_function('myapp_auth_private.set_session_secret(uuid, text, text, timestamptz)'::regprocedure, 'void'::regtype, false, true, 'VOLATILE');


