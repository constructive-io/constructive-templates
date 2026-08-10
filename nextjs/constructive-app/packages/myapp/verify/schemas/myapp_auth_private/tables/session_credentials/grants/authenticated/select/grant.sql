-- Verify: schemas/myapp_auth_private/tables/session_credentials/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_auth_private.session_credentials'::regclass, 'authenticated', 'SELECT', NULL, true);


