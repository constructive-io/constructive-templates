-- Revert: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/owner_id/column


ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  DROP COLUMN owner_id RESTRICT;


