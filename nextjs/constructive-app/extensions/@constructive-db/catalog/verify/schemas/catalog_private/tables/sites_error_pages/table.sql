-- Verify: schemas/catalog_private/tables/sites_error_pages/table


SELECT assert_table(CAST('catalog_private.sites_error_pages' AS regclass), false, NULL);