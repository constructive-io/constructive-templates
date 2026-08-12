-- Revert: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/service/column


ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  DROP COLUMN service RESTRICT;


