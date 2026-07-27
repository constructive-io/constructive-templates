-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/backup_eligible/alterations/alt0000000002


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN backup_eligible DROP DEFAULT;


