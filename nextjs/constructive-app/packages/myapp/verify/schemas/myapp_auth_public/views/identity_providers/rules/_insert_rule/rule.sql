-- Verify: schemas/myapp_auth_public/views/identity_providers/rules/_insert_rule/rule


SELECT assert_view_rule('myapp_auth_public.identity_providers'::regclass, '_insert_rule', 'INSERT');


