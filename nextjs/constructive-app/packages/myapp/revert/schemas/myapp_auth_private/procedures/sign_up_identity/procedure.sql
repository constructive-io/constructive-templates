-- Revert: schemas/myapp_auth_private/procedures/sign_up_identity/procedure


DROP FUNCTION myapp_auth_private.sign_up_identity ( text, text, text, jsonb, text, boolean, text );


