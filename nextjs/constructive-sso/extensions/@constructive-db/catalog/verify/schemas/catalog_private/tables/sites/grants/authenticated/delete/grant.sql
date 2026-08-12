-- Verify: schemas/catalog_private/tables/sites/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('catalog_private.sites' AS regclass), 'authenticated', 'DELETE', NULL, true);