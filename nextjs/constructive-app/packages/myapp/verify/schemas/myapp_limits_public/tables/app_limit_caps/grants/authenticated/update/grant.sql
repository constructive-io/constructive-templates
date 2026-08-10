-- Verify: schemas/myapp_limits_public/tables/app_limit_caps/grants/authenticated/update/grant


SELECT assert_table_grant('myapp_limits_public.app_limit_caps'::regclass, 'authenticated', 'UPDATE', NULL, true);


