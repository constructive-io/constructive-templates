-- Verify: schemas/catalog_private/tables/functions/table


SELECT assert_table(CAST('catalog_private.functions' AS regclass), false, NULL);