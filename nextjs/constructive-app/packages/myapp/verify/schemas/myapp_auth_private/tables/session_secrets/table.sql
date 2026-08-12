-- Verify: schemas/myapp_auth_private/tables/session_secrets/table


SELECT assert_table('myapp_auth_private.session_secrets'::regclass, false, NULL);


