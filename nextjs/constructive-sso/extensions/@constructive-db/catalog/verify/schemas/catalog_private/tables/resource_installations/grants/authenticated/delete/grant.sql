-- Verify: schemas/catalog_private/tables/resource_installations/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('catalog_private.resource_installations' AS regclass), 'authenticated', 'DELETE', NULL, true);