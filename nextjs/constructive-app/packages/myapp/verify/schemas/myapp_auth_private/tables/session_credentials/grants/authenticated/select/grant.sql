-- Verify: schemas/myapp_auth_private/tables/session_credentials/grants/authenticated/select/grant


SELECT verify_table_grant('myapp_auth_private.session_credentials', 'SELECT', 'authenticated');


