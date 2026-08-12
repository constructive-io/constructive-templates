-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/created_at/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD COLUMN created_at timestamptz;

