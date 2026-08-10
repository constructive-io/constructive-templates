-- Verify: schemas/myapp_store_public/views/app_internal_secrets/rules/_update_rule/rule


SELECT assert_view_rule('myapp_store_public.app_internal_secrets'::regclass, '_update_rule', 'UPDATE');


