-- Verify: schemas/catalog_private/tables/apps/indexes/apps_is_visible_idx


SELECT assert_index(CAST('catalog_private.apps_is_visible_idx' AS regclass), CAST('catalog_private.apps' AS regclass), false);