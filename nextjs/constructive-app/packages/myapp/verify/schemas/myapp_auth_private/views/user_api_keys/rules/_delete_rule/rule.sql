-- Verify: schemas/myapp_auth_private/views/user_api_keys/rules/_delete_rule/rule


SELECT assert_view_rule('myapp_auth_private.user_api_keys'::regclass, '_delete_rule', 'DELETE');


