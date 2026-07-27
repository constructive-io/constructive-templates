-- Revert: schemas/myapp_auth_private/tables/identity_providers/columns/kind/column


ALTER TABLE myapp_auth_private.identity_providers 
  DROP COLUMN kind RESTRICT;


