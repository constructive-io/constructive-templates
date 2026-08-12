-- Verify: schemas/catalog_public/tables/resource_installations/indexes/resource_installations_database_id_idx


SELECT verify_index('catalog_public.resource_installations', 'resource_installations_database_id_idx');