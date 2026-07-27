-- Revert: schemas/myapp_auth_private/tables/identity_providers/columns/slug/alterations/alt0000000001


ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN slug DROP NOT NULL;


