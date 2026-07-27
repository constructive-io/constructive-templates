-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/last_used_at/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD COLUMN last_used_at timestamptz;

