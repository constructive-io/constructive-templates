-- Verify: schemas/myapp_user_identifiers_private/tables/connected_accounts/indexes/connected_accounts_created_at_idx


SELECT verify_index('myapp_user_identifiers_private.connected_accounts', 'connected_accounts_created_at_idx');


