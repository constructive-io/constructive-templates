-- Verify: schemas/catalog_private/tables/apps/indexes/apps_updated_at_idx


SELECT assert_index(CAST('catalog_private.apps_updated_at_idx' AS regclass), CAST('catalog_private.apps' AS regclass), false);