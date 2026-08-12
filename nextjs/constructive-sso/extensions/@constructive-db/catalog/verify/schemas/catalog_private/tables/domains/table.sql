-- Verify: schemas/catalog_private/tables/domains/table


SELECT assert_table(CAST('catalog_private.domains' AS regclass), false, NULL);