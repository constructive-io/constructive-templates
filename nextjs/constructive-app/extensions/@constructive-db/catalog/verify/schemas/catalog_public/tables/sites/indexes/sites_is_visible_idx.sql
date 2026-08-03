-- Verify: schemas/catalog_public/tables/sites/indexes/sites_is_visible_idx


SELECT verify_index('catalog_public.sites', 'sites_is_visible_idx');