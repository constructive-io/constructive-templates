-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/backup_state/alterations/alt0000000001


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN backup_state DROP NOT NULL;


