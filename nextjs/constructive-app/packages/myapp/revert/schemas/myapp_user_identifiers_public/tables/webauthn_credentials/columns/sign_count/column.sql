-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/sign_count/column


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  DROP COLUMN sign_count RESTRICT;


