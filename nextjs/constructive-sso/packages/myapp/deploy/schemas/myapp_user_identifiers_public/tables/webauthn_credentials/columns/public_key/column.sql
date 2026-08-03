-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/public_key/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD COLUMN public_key bytea;

