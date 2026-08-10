-- Verify: schemas/myapp_auth_public/views/org_api_key_list/rules/_delete_rule/rule


SELECT assert_view_rule('myapp_auth_public.org_api_key_list'::regclass, '_delete_rule', 'DELETE');


