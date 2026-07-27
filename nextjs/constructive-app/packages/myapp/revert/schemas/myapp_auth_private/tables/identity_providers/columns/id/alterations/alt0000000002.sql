-- Revert: schemas/myapp_auth_private/tables/identity_providers/columns/id/alterations/alt0000000002


ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN id DROP DEFAULT;


