-- Verify: schemas/myapp_limits_public/tables/app_limit_credit_code_items/indexes/app_limit_credit_code_items_default_limit_id_idx


SELECT assert_index('myapp_limits_public.app_limit_credit_code_items_default_limit_id_idx'::regclass, 'myapp_limits_public.app_limit_credit_code_items'::regclass, false);


