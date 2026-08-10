-- Verify: schemas/myapp_auth_private/procedures/consume_session_secret/procedure


SELECT assert_function('myapp_auth_private.consume_session_secret(uuid, text)'::regprocedure, 'text'::regtype, false, true, 'VOLATILE');


