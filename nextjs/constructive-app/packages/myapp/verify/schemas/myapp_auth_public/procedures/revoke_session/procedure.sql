-- Verify: schemas/myapp_auth_public/procedures/revoke_session/procedure


SELECT assert_function('myapp_auth_public.revoke_session(uuid)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


