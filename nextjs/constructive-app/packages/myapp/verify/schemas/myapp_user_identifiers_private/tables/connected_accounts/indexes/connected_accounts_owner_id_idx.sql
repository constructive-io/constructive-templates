-- Verify: schemas/myapp_user_identifiers_private/tables/connected_accounts/indexes/connected_accounts_owner_id_idx


SELECT verify_index('myapp_user_identifiers_private.connected_accounts', 'connected_accounts_owner_id_idx');


