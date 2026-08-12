-- Verify: schemas/catalog_public/tables/resource_definitions/indexes/resource_definitions_created_at_idx


SELECT verify_index('catalog_public.resource_definitions', 'resource_definitions_created_at_idx');