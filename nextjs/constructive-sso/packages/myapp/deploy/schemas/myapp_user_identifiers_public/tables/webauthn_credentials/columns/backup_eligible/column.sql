-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/backup_eligible/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD COLUMN backup_eligible boolean;

