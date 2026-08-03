-- Verify: schemas/catalog_public/tables/sites/indexes/sites_created_at_idx


SELECT verify_index('catalog_public.sites', 'sites_created_at_idx');