-- Verify: schemas/myapp_limits_public/tables/app_limit_credit_redemptions/table


SELECT assert_table('myapp_limits_public.app_limit_credit_redemptions'::regclass, false, NULL);


