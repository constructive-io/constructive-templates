-- Verify: schemas/myapp_user_identifiers_private/tables/connected_accounts/indexes/connected_accounts_created_at_idx


SELECT assert_index('myapp_user_identifiers_private.connected_accounts_created_at_idx'::regclass, 'myapp_user_identifiers_private.connected_accounts'::regclass, false);


