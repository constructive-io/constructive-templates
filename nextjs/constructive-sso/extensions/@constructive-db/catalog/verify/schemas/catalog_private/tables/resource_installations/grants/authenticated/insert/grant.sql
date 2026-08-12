-- Verify: schemas/catalog_private/tables/resource_installations/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('catalog_private.resource_installations' AS regclass), 'authenticated', 'INSERT', NULL, true);