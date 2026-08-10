-- Verify: schemas/catalog_private/tables/bindings/table


SELECT assert_table(CAST('catalog_private.bindings' AS regclass), false, NULL);