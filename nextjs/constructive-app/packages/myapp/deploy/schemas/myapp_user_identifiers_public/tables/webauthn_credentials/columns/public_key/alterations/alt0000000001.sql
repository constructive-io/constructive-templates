-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/public_key/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/public_key/column


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN public_key SET NOT NULL;

