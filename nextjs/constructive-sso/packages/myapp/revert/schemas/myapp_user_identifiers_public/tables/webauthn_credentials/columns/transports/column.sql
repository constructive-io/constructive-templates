-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/transports/column


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  DROP COLUMN transports RESTRICT;


