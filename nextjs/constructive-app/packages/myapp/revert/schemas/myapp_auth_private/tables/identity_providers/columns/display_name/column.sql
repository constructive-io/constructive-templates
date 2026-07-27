-- Revert: schemas/myapp_auth_private/tables/identity_providers/columns/display_name/column


ALTER TABLE myapp_auth_private.identity_providers 
  DROP COLUMN display_name RESTRICT;


