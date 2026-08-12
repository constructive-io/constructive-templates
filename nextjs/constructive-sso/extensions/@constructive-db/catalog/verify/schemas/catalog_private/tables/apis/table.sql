-- Verify: schemas/catalog_private/tables/apis/table


SELECT assert_table(CAST('catalog_private.apis' AS regclass), false, NULL);