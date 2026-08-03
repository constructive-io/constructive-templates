-- Revert: schemas/myapp_auth_private/tables/identity_providers/columns/display_name/alterations/alt0000000001


ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN display_name DROP NOT NULL;


