-- Verify: schemas/myapp_limits_public/tables/org_limit_credits/table


SELECT assert_table('myapp_limits_public.org_limit_credits'::regclass, false, NULL);


