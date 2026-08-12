-- Verify: schemas/catalog_private/tables/apps/table


SELECT assert_table(CAST('catalog_private.apps' AS regclass), false, NULL);