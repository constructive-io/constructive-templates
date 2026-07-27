-- Verify: schemas/myapp_user_identifiers_public/views/user_connected_accounts/grants/authenticated/SELECT/grant


SELECT verify_table_grant('myapp_user_identifiers_public.user_connected_accounts', 'SELECT', 'authenticated');


