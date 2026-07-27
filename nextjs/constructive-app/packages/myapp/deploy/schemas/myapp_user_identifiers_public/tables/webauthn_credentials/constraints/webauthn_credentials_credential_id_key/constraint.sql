-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/constraints/webauthn_credentials_credential_id_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD CONSTRAINT webauthn_credentials_credential_id_key 
    UNIQUE (credential_id);

