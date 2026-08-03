-- Verify: schemas/routing_public/tables/platform_api_schemas/indexes/platform_api_schemas_schema_id_idx


SELECT verify_index('routing_public.platform_api_schemas', 'platform_api_schemas_schema_id_idx');