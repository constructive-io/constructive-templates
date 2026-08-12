-- Verify: schemas/routing_public/tables/api_schemas/table


SELECT assert_table(CAST('routing_public.api_schemas' AS regclass), false, NULL);