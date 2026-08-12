-- Verify: schemas/catalog_private/tables/resources/table


SELECT assert_table(CAST('catalog_private.resources' AS regclass), false, NULL);