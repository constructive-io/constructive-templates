-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/policies/enable_row_level_security
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ENABLE ROW LEVEL SECURITY;

