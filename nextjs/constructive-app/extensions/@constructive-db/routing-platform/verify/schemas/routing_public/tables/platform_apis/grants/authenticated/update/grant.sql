-- Verify: schemas/routing_public/tables/platform_apis/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.platform_apis' AS regclass), 'authenticated', 'UPDATE', NULL, true);