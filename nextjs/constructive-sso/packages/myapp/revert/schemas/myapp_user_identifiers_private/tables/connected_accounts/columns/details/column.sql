-- Revert: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/details/column


ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  DROP COLUMN details RESTRICT;


