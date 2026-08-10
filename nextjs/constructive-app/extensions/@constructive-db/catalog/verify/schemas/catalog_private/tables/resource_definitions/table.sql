-- Verify: schemas/catalog_private/tables/resource_definitions/table


SELECT assert_table(CAST('catalog_private.resource_definitions' AS regclass), false, NULL);