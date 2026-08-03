-- Verify: schemas/catalog_public/tables/resources/indexes/resources_updated_at_idx


SELECT verify_index('catalog_public.resources', 'resources_updated_at_idx');