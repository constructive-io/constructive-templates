-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/client_secret_id/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/table


ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN client_secret_id uuid;

