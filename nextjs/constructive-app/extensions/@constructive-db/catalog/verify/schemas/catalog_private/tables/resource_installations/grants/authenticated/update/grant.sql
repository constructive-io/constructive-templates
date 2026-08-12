-- Verify: schemas/catalog_private/tables/resource_installations/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('catalog_private.resource_installations' AS regclass), 'authenticated', 'UPDATE', NULL, true);