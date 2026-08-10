-- Verify: schemas/myapp_user_identifiers_private/tables/connected_accounts/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_user_identifiers_private.connected_accounts'::regclass, 'authenticated', 'SELECT', NULL, true);


