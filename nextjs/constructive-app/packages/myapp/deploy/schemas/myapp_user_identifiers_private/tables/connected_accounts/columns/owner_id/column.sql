-- Deploy: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/owner_id/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_private/schema
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/table


ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ADD COLUMN owner_id uuid;

