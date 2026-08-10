-- Verify: schemas/myapp_auth_private/procedures/webauthn_begin_registration/procedure


SELECT assert_function('myapp_auth_private.webauthn_begin_registration(uuid)'::regprocedure, 'jsonb'::regtype, false, true, 'VOLATILE');


