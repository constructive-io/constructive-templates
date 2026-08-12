-- Verify: schemas/catalog_public/tables/apps/indexes/apps_is_visible_idx


SELECT verify_index('catalog_public.apps', 'apps_is_visible_idx');