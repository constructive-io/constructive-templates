-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/allow_link_by_email/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/table
-- requires: schemas/myapp_auth_private/tables/identity_providers/columns/allow_link_by_email/column


ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN allow_link_by_email SET DEFAULT false;

