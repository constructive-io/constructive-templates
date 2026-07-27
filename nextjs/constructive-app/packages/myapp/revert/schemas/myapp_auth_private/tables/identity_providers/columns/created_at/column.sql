-- Revert: schemas/myapp_auth_private/tables/identity_providers/columns/created_at/column


ALTER TABLE myapp_auth_private.identity_providers 
  DROP COLUMN created_at RESTRICT;


