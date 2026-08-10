-- Verify: schemas/myapp_limits_public/tables/org_limit_events/table


SELECT assert_table('myapp_limits_public.org_limit_events'::regclass, true, NULL);


