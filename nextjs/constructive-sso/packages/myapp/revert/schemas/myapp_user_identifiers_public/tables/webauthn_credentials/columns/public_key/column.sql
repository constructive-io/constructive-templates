-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/public_key/column


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  DROP COLUMN public_key RESTRICT;


