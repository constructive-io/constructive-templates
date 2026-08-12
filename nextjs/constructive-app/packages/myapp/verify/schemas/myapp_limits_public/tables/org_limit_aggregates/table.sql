-- Verify: schemas/myapp_limits_public/tables/org_limit_aggregates/table


SELECT assert_table('myapp_limits_public.org_limit_aggregates'::regclass, false, NULL);


