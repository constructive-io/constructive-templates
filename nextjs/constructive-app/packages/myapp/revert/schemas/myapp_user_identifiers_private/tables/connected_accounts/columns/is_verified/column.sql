-- Revert: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/is_verified/column


ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  DROP COLUMN is_verified RESTRICT;


