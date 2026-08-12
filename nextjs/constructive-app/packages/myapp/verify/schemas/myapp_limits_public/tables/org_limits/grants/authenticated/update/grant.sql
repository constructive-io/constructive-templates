-- Verify: schemas/myapp_limits_public/tables/org_limits/grants/authenticated/update/grant


SELECT assert_table_grant('myapp_limits_public.org_limits'::regclass, 'authenticated', 'UPDATE', NULL, true);


