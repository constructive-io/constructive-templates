-- Verify: schemas/routing_public/tables/api_schemas/indexes/api_schemas_database_id_idx


SELECT assert_index(CAST('routing_public.api_schemas_database_id_idx' AS regclass), CAST('routing_public.api_schemas' AS regclass), false);