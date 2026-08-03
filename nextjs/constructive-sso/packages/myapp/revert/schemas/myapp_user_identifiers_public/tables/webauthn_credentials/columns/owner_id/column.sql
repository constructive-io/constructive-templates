-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/owner_id/column


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  DROP COLUMN owner_id RESTRICT;


