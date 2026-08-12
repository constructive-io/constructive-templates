-- Verify: schemas/catalog_private/tables/resource_installations/table


SELECT assert_table(CAST('catalog_private.resource_installations' AS regclass), false, NULL);