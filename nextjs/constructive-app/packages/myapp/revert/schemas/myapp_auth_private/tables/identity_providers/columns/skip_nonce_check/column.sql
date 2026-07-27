-- Revert: schemas/myapp_auth_private/tables/identity_providers/columns/skip_nonce_check/column


ALTER TABLE myapp_auth_private.identity_providers 
  DROP COLUMN skip_nonce_check RESTRICT;


