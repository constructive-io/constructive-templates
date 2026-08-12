-- Verify: schemas/myapp_limits_public/tables/org_limit_credits/grants/authenticated/insert/grant


SELECT assert_table_grant('myapp_limits_public.org_limit_credits'::regclass, 'authenticated', 'INSERT', NULL, true);


