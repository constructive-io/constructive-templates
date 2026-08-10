-- Verify: schemas/myapp_auth_private/tables/session_credentials/table


SELECT assert_table('myapp_auth_private.session_credentials'::regclass, false, NULL);


