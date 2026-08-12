-- Verify: schemas/myapp_user_identifiers_public/views/user_connected_accounts/rules/_delete_rule/rule


SELECT assert_view_rule('myapp_user_identifiers_public.user_connected_accounts'::regclass, '_delete_rule', 'DELETE');


