-- Revert: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/owner_id/alterations/alt0000000001


ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ALTER COLUMN owner_id DROP NOT NULL;


