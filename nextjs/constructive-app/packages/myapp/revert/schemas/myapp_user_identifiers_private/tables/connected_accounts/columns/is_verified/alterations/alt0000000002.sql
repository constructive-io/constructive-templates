-- Revert: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/is_verified/alterations/alt0000000002


ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ALTER COLUMN is_verified DROP DEFAULT;


