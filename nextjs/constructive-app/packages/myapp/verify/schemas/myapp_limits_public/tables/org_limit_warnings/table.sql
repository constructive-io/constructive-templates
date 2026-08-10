-- Verify: schemas/myapp_limits_public/tables/org_limit_warnings/table


SELECT assert_table('myapp_limits_public.org_limit_warnings'::regclass, false, NULL);


