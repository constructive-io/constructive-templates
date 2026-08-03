-- Verify: schemas/routing_public/tables/platform_api_schemas/indexes/platform_api_schemas_created_at_idx


SELECT verify_index('routing_public.platform_api_schemas', 'platform_api_schemas_created_at_idx');