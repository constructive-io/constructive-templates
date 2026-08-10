-- Verify: schemas/myapp_auth_private/views/user_api_keys/rules/_insert_rule/rule


SELECT assert_view_rule('myapp_auth_private.user_api_keys'::regclass, '_insert_rule', 'INSERT');


