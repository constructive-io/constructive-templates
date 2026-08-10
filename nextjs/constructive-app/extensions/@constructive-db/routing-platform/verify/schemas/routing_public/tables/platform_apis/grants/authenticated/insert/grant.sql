-- Verify: schemas/routing_public/tables/platform_apis/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.platform_apis' AS regclass), 'authenticated', 'INSERT', NULL, true);