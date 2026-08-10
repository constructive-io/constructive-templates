-- Verify: schemas/myapp_auth_private/views/user_sessions/view


SELECT assert_view('myapp_auth_private.user_sessions'::regclass, false, true);


