-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/updated_at/column


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  DROP COLUMN updated_at RESTRICT;


