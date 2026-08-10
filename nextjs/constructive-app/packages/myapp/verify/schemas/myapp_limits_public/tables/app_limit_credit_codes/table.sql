-- Verify: schemas/myapp_limits_public/tables/app_limit_credit_codes/table


SELECT assert_table('myapp_limits_public.app_limit_credit_codes'::regclass, false, NULL);


