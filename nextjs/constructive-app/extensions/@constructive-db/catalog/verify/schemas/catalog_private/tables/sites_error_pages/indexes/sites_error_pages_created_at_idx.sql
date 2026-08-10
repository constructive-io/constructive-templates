-- Verify: schemas/catalog_private/tables/sites_error_pages/indexes/sites_error_pages_created_at_idx


SELECT assert_index(CAST('catalog_private.sites_error_pages_created_at_idx' AS regclass), CAST('catalog_private.sites_error_pages' AS regclass), false);