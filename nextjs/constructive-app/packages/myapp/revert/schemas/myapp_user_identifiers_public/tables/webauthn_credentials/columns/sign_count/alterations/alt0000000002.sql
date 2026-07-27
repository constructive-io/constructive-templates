-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/sign_count/alterations/alt0000000002


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN sign_count DROP DEFAULT;


