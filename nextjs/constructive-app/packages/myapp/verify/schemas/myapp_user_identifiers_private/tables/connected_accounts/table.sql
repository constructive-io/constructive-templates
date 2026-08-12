-- Verify: schemas/myapp_user_identifiers_private/tables/connected_accounts/table


SELECT assert_table('myapp_user_identifiers_private.connected_accounts'::regclass, false, NULL);


