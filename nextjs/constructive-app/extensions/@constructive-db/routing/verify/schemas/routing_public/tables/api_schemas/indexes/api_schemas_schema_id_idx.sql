-- Verify: schemas/routing_public/tables/api_schemas/indexes/api_schemas_schema_id_idx


SELECT verify_index('routing_public.api_schemas', 'api_schemas_schema_id_idx');