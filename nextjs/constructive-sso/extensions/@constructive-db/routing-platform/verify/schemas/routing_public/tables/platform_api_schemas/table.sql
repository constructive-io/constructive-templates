-- Verify: schemas/routing_public/tables/platform_api_schemas/table


SELECT assert_table(CAST('routing_public.platform_api_schemas' AS regclass), false, NULL);