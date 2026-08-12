-- Verify: schemas/catalog_private/tables/namespaces/table


SELECT assert_table(CAST('catalog_private.namespaces' AS regclass), false, NULL);