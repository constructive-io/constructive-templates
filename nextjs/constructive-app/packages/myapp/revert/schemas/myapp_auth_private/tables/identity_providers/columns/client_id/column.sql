-- Revert: schemas/myapp_auth_private/tables/identity_providers/columns/client_id/column


ALTER TABLE myapp_auth_private.identity_providers 
  DROP COLUMN client_id RESTRICT;


