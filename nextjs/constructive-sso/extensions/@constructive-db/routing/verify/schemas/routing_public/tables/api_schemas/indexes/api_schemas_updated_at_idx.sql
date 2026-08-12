-- Verify: schemas/routing_public/tables/api_schemas/indexes/api_schemas_updated_at_idx


SELECT verify_index('routing_public.api_schemas', 'api_schemas_updated_at_idx');