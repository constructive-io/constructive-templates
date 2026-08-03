-- Revert: schemas/myapp_auth_private/tables/identity_providers/columns/slug/column


ALTER TABLE myapp_auth_private.identity_providers 
  DROP COLUMN slug RESTRICT;


