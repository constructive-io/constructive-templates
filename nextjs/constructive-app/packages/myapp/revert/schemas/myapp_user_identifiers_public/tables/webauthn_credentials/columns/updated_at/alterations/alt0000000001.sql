-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/updated_at/alterations/alt0000000001


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN updated_at DROP DEFAULT;


