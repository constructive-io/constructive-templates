-- Verify: schemas/myapp_limits_public/tables/app_limits/grants/authenticated/update/grant


SELECT assert_table_grant('myapp_limits_public.app_limits'::regclass, 'authenticated', 'UPDATE', NULL, true);


