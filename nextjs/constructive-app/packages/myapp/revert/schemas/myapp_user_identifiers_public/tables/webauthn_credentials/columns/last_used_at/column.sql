-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/last_used_at/column


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  DROP COLUMN last_used_at RESTRICT;


