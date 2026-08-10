-- Verify: schemas/catalog_private/tables/sites/indexes/sites_created_at_idx


SELECT assert_index(CAST('catalog_private.sites_created_at_idx' AS regclass), CAST('catalog_private.sites' AS regclass), false);