-- Verify: schemas/routing_public/tables/api_schemas/indexes/api_schemas_created_at_idx


SELECT verify_index('routing_public.api_schemas', 'api_schemas_created_at_idx');