-- Verify: schemas/myapp_limits_public/tables/app_limit_caps/table


SELECT assert_table('myapp_limits_public.app_limit_caps'::regclass, false, NULL);


