-- Revert: schemas/myapp_auth_private/procedures/webauthn_finish_sign_in/procedure


DROP FUNCTION myapp_auth_private.webauthn_finish_sign_in ( text, bigint, boolean, text );


