-- Revert: schemas/myapp_auth_private/tables/identity_providers/columns/skip_nonce_check/alterations/alt0000000001


ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN skip_nonce_check DROP NOT NULL;


