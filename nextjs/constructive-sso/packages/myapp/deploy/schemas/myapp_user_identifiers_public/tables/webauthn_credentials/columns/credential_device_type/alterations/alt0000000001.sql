-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/credential_device_type/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/credential_device_type/column


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN credential_device_type SET NOT NULL;

