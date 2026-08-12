-- Verify: schemas/catalog_private/tables/resource_definitions/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('catalog_private.resource_definitions' AS regclass), 'authenticated', 'UPDATE', NULL, true);