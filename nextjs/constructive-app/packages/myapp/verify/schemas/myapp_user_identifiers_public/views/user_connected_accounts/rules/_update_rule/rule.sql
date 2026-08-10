-- Verify: schemas/myapp_user_identifiers_public/views/user_connected_accounts/rules/_update_rule/rule


SELECT assert_view_rule('myapp_user_identifiers_public.user_connected_accounts'::regclass, '_update_rule', 'UPDATE');


