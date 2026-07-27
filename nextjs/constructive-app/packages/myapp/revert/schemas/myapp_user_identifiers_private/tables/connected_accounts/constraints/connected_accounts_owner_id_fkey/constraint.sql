-- Revert: schemas/myapp_user_identifiers_private/tables/connected_accounts/constraints/connected_accounts_owner_id_fkey/constraint


ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  DROP CONSTRAINT connected_accounts_owner_id_fkey;


