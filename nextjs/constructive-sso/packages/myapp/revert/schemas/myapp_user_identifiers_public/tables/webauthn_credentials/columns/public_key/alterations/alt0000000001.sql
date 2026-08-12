-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/public_key/alterations/alt0000000001


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN public_key DROP NOT NULL;


