-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/skip_nonce_check/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/table


ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN skip_nonce_check boolean;

