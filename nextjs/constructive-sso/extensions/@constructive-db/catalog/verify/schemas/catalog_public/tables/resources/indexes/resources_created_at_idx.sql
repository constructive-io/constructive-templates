-- Verify: schemas/catalog_public/tables/resources/indexes/resources_created_at_idx


SELECT verify_index('catalog_public.resources', 'resources_created_at_idx');