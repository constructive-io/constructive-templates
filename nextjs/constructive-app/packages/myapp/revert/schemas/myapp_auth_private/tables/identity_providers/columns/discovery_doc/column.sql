-- Revert: schemas/myapp_auth_private/tables/identity_providers/columns/discovery_doc/column


ALTER TABLE myapp_auth_private.identity_providers 
  DROP COLUMN discovery_doc RESTRICT;


