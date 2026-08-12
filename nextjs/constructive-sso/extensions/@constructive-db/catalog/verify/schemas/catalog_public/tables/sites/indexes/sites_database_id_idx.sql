-- Verify: schemas/catalog_public/tables/sites/indexes/sites_database_id_idx


SELECT verify_index('catalog_public.sites', 'sites_database_id_idx');