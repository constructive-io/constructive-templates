-- Verify: schemas/catalog_public/tables/resources/indexes/resources_database_id_idx


SELECT verify_index('catalog_public.resources', 'resources_database_id_idx');