-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/owner_id/alterations/alt0000000002


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN owner_id DROP DEFAULT;


