-- Revert: schemas/myapp_auth_private/tables/identity_providers/columns/extra_authorization_params/alterations/alt0000000001


ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN extra_authorization_params DROP NOT NULL;


