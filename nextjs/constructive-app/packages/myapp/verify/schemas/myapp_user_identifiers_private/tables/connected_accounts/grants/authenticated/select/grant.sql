-- Verify: schemas/myapp_user_identifiers_private/tables/connected_accounts/grants/authenticated/select/grant


SELECT verify_table_grant('myapp_user_identifiers_private.connected_accounts', 'select', 'authenticated');


