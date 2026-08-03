-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/webauthn_user_id/column


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  DROP COLUMN webauthn_user_id RESTRICT;


