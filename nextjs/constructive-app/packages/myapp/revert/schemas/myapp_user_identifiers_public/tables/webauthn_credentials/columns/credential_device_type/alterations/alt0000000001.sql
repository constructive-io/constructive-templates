-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/credential_device_type/alterations/alt0000000001


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN credential_device_type DROP NOT NULL;


