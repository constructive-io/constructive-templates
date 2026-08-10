-- Verify: schemas/myapp_limits_public/tables/org_limits/grants/authenticated/delete/grant


SELECT assert_table_grant('myapp_limits_public.org_limits'::regclass, 'authenticated', 'DELETE', NULL, true);


