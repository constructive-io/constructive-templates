-- Verify: schemas/myapp_auth_private/procedures/webauthn_begin_sign_in/procedure


SELECT assert_function('myapp_auth_private.webauthn_begin_sign_in(uuid)'::regprocedure, 'jsonb'::regtype, false, true, 'VOLATILE');


