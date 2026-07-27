-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/email_optional/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/table
-- requires: schemas/myapp_auth_private/tables/identity_providers/columns/email_optional/column


ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN email_optional SET DEFAULT false;

