-- Deploy: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/identifier/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_private/schema
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/table
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/identifier/column


ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ALTER COLUMN identifier SET NOT NULL;

