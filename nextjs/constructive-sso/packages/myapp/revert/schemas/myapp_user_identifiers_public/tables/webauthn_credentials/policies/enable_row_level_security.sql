-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/policies/enable_row_level_security


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  DISABLE ROW LEVEL SECURITY;


