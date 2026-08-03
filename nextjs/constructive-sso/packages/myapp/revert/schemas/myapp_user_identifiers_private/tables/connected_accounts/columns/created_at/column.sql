-- Revert: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/created_at/column


ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  DROP COLUMN created_at RESTRICT;


