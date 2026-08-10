-- Verify: schemas/myapp_auth_private/views/user_sessions/rules/_delete_rule/rule


SELECT assert_view_rule('myapp_auth_private.user_sessions'::regclass, '_delete_rule', 'DELETE');


