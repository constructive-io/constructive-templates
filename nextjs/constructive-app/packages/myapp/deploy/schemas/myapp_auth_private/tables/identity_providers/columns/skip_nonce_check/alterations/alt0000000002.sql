-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/skip_nonce_check/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/table
-- requires: schemas/myapp_auth_private/tables/identity_providers/columns/skip_nonce_check/column


ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN skip_nonce_check SET DEFAULT false;

