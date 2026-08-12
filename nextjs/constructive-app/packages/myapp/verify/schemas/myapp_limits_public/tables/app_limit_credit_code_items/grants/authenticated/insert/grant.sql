-- Verify: schemas/myapp_limits_public/tables/app_limit_credit_code_items/grants/authenticated/insert/grant


SELECT assert_table_grant('myapp_limits_public.app_limit_credit_code_items'::regclass, 'authenticated', 'INSERT', NULL, true);


