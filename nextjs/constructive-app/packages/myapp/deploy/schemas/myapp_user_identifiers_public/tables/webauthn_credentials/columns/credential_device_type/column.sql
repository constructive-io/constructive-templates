-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/credential_device_type/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD COLUMN credential_device_type text;

