-- Revert: schemas/myapp_auth_private/tables/identity_providers/columns/pkce_enabled/alterations/alt0000000001


ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN pkce_enabled DROP NOT NULL;


