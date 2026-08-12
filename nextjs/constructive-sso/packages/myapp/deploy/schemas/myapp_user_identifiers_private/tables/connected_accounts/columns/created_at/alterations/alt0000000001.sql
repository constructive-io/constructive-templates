-- Deploy: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/created_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_private/schema
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/table
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/created_at/column


ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ALTER COLUMN created_at SET DEFAULT now();

