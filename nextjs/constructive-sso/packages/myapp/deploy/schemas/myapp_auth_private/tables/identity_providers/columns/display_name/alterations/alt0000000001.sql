-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/display_name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/table
-- requires: schemas/myapp_auth_private/tables/identity_providers/columns/display_name/column


ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN display_name SET NOT NULL;

