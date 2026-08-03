-- Verify: schemas/catalog_public/tables/sites/indexes/sites_updated_at_idx


SELECT verify_index('catalog_public.sites', 'sites_updated_at_idx');