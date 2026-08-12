-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/name/column


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  DROP COLUMN name RESTRICT;


