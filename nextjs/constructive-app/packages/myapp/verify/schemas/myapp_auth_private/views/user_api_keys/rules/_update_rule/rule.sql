-- Verify: schemas/myapp_auth_private/views/user_api_keys/rules/_update_rule/rule


SELECT assert_view_rule('myapp_auth_private.user_api_keys'::regclass, '_update_rule', 'UPDATE');


