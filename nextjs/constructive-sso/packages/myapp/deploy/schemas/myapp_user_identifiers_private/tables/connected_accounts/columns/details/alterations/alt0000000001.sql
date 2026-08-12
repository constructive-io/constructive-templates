-- Deploy: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/details/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_private/schema
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/table
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/details/column


ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ALTER COLUMN details SET NOT NULL;

