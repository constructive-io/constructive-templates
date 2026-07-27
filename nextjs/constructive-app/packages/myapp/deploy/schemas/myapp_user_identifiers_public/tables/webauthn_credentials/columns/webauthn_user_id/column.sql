-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/webauthn_user_id/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD COLUMN webauthn_user_id text;

