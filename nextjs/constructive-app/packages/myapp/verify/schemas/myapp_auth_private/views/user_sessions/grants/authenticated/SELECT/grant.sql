-- Verify: schemas/myapp_auth_private/views/user_sessions/grants/authenticated/SELECT/grant


SELECT assert_table_grant('myapp_auth_private.user_sessions'::regclass, 'authenticated', 'SELECT', NULL, true);


