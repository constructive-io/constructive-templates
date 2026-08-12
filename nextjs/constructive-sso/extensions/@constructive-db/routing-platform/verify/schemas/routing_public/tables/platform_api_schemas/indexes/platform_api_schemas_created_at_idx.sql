-- Verify: schemas/routing_public/tables/platform_api_schemas/indexes/platform_api_schemas_created_at_idx


SELECT assert_index(CAST('routing_public.platform_api_schemas_created_at_idx' AS regclass), CAST('routing_public.platform_api_schemas' AS regclass), false);