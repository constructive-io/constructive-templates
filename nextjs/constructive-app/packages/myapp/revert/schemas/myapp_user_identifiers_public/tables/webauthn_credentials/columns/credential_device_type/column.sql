-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/credential_device_type/column


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  DROP COLUMN credential_device_type RESTRICT;


