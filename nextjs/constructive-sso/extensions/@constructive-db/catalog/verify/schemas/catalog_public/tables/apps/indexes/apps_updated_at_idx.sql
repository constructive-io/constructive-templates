-- Verify: schemas/catalog_public/tables/apps/indexes/apps_updated_at_idx


SELECT verify_index('catalog_public.apps', 'apps_updated_at_idx');