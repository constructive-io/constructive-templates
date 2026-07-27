-- Deploy: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/is_verified/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_private/schema
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/table


ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ADD COLUMN is_verified boolean;

