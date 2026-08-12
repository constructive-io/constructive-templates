-- Verify: schemas/catalog_private/tables/sites/table


SELECT assert_table(CAST('catalog_private.sites' AS regclass), false, NULL);