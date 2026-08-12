-- Verify: schemas/catalog_private/tables/sites_error_pages/indexes/sites_error_pages_site_id_idx


SELECT assert_index(CAST('catalog_private.sites_error_pages_site_id_idx' AS regclass), CAST('catalog_private.sites_error_pages' AS regclass), false);