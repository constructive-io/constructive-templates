-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/backup_state/column


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  DROP COLUMN backup_state RESTRICT;


