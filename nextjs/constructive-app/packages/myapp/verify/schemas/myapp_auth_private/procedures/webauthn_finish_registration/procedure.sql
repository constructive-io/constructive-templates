-- Verify: schemas/myapp_auth_private/procedures/webauthn_finish_registration/procedure


SELECT assert_function('myapp_auth_private.webauthn_finish_registration(text, bytea, bigint, text[], text, boolean, boolean, text, uuid, text)'::regprocedure, 'uuid'::regtype, false, true, 'VOLATILE');


