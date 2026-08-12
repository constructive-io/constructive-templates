-- Verify: schemas/myapp_limits_public/tables/app_limit_defaults/table


SELECT assert_table('myapp_limits_public.app_limit_defaults'::regclass, false, NULL);


