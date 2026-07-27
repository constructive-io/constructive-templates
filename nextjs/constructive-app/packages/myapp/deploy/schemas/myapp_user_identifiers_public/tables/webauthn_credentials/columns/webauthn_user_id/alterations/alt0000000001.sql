-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/webauthn_user_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/webauthn_user_id/column


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN webauthn_user_id SET NOT NULL;

