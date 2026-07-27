-- Revert: schemas/myapp_auth_private/tables/identity_providers/columns/email_optional/column


ALTER TABLE myapp_auth_private.identity_providers 
  DROP COLUMN email_optional RESTRICT;


