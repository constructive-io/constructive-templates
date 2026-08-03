-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/id/column


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN id SET NOT NULL;

