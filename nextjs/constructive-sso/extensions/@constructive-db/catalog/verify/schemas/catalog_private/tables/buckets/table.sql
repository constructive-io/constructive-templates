-- Verify: schemas/catalog_private/tables/buckets/table


SELECT assert_table(CAST('catalog_private.buckets' AS regclass), false, NULL);