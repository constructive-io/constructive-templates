-- Verify: schemas/routing_public/tables/platform_api_schemas/indexes/platform_api_schemas_updated_at_idx


SELECT verify_index('routing_public.platform_api_schemas', 'platform_api_schemas_updated_at_idx');