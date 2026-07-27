-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/backup_state/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/backup_state/column


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN backup_state SET DEFAULT false;

