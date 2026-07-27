-- Deploy: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/is_verified/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_private/schema
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/table
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/is_verified/column


ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ALTER COLUMN is_verified SET NOT NULL;

