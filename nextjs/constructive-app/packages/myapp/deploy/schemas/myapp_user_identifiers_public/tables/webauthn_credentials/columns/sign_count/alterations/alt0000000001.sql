-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/sign_count/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/sign_count/column


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN sign_count SET NOT NULL;

