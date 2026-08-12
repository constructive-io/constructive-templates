-- Verify: schemas/myapp_auth_public/views/identity_providers/rules/_delete_rule/rule


SELECT assert_view_rule('myapp_auth_public.identity_providers'::regclass, '_delete_rule', 'DELETE');


