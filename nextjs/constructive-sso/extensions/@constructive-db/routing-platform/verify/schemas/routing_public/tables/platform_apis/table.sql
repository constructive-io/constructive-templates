-- Verify: schemas/routing_public/tables/platform_apis/table


SELECT assert_table(CAST('routing_public.platform_apis' AS regclass), false, NULL);