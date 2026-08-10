-- Verify: schemas/myapp_limits_public/tables/app_limits/table


SELECT assert_table('myapp_limits_public.app_limits'::regclass, false, NULL);


