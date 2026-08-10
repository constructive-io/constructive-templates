-- Verify: schemas/myapp_auth_private/tables/sessions/table


SELECT assert_table('myapp_auth_private.sessions'::regclass, false, NULL);


