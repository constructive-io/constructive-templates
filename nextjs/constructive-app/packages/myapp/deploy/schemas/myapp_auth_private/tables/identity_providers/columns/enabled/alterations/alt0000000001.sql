-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/enabled/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/table
-- requires: schemas/myapp_auth_private/tables/identity_providers/columns/enabled/column


ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN enabled SET NOT NULL;

