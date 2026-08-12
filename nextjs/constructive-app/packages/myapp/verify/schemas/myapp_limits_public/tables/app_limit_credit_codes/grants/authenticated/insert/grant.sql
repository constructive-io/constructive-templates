-- Verify: schemas/myapp_limits_public/tables/app_limit_credit_codes/grants/authenticated/insert/grant


SELECT assert_table_grant('myapp_limits_public.app_limit_credit_codes'::regclass, 'authenticated', 'INSERT', NULL, true);


