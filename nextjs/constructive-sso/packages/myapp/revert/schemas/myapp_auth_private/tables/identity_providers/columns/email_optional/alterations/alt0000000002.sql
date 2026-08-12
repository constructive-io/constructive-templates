-- Revert: schemas/myapp_auth_private/tables/identity_providers/columns/email_optional/alterations/alt0000000002


ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN email_optional DROP DEFAULT;


