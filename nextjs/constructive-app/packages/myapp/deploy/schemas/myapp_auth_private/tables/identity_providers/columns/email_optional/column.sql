-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/email_optional/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/table


ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN email_optional boolean;

