-- Verify: schemas/myapp_auth_private/views/user_sessions/rules/_insert_rule/rule


SELECT assert_view_rule('myapp_auth_private.user_sessions'::regclass, '_insert_rule', 'INSERT');


