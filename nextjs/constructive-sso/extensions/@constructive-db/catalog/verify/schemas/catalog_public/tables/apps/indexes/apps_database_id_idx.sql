-- Verify: schemas/catalog_public/tables/apps/indexes/apps_database_id_idx


SELECT verify_index('catalog_public.apps', 'apps_database_id_idx');