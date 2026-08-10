-- Verify: schemas/myapp_limits_public/tables/org_limits/table


SELECT assert_table('myapp_limits_public.org_limits'::regclass, false, NULL);


