-- Verify: schemas/myapp_store_public/views/app_internal_secrets/rules/_delete_rule/rule


SELECT assert_view_rule('myapp_store_public.app_internal_secrets'::regclass, '_delete_rule', 'DELETE');


