-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/constraints/webauthn_credentials_credential_id_key/constraint


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  DROP CONSTRAINT webauthn_credentials_credential_id_key;


