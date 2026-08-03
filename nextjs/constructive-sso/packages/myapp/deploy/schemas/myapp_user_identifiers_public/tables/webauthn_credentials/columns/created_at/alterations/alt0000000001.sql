-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/created_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/created_at/column


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN created_at SET DEFAULT now();

