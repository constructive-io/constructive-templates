-- Revert: schemas/myapp_user_identifiers_private/tables/connected_accounts/policies/enable_row_level_security


ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  DISABLE ROW LEVEL SECURITY;


