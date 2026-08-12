-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/created_at/alterations/alt0000000001


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN created_at DROP DEFAULT;


