-- Deploy: schemas/myapp_auth_private/tables/identity_providers/policies/enable_row_level_security
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/table


ALTER TABLE myapp_auth_private.identity_providers 
  ENABLE ROW LEVEL SECURITY;

