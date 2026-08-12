-- Verify: schemas/catalog_public/tables/resource_installations/indexes/resource_installations_created_at_idx


SELECT verify_index('catalog_public.resource_installations', 'resource_installations_created_at_idx');