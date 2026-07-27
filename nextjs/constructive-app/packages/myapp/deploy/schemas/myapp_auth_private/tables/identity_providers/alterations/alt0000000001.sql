-- Deploy: schemas/myapp_auth_private/tables/identity_providers/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/table


ALTER TABLE myapp_auth_private.identity_providers 
  DISABLE ROW LEVEL SECURITY;

