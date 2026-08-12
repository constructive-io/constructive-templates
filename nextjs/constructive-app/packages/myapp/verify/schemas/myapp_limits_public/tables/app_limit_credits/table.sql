-- Verify: schemas/myapp_limits_public/tables/app_limit_credits/table


SELECT assert_table('myapp_limits_public.app_limit_credits'::regclass, false, NULL);


