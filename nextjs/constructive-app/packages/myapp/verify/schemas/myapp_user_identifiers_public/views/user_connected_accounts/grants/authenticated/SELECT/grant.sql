-- Verify: schemas/myapp_user_identifiers_public/views/user_connected_accounts/grants/authenticated/SELECT/grant


SELECT assert_table_grant('myapp_user_identifiers_public.user_connected_accounts'::regclass, 'authenticated', 'SELECT', NULL, true);


