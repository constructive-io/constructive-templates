-- Verify: schemas/catalog_private/tables/sites/indexes/sites_is_visible_idx


SELECT assert_index(CAST('catalog_private.sites_is_visible_idx' AS regclass), CAST('catalog_private.sites' AS regclass), false);