-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/constraints/webauthn_credentials_webauthn_user_id_owner_id_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD CONSTRAINT webauthn_credentials_webauthn_user_id_owner_id_key 
    UNIQUE (webauthn_user_id, owner_id);

