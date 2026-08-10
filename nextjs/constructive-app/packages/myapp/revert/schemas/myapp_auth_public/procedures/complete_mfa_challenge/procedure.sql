-- Revert: schemas/myapp_auth_public/procedures/complete_mfa_challenge/procedure


DROP FUNCTION myapp_auth_public.complete_mfa_challenge ( uuid, text, text, text, text, boolean, boolean, text, text );


