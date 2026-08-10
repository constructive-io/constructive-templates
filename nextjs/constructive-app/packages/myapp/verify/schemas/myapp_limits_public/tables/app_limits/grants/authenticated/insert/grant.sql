-- Verify: schemas/myapp_limits_public/tables/app_limits/grants/authenticated/insert/grant


SELECT assert_table_grant('myapp_limits_public.app_limits'::regclass, 'authenticated', 'INSERT', NULL, true);


