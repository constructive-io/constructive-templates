-- Verify: schemas/catalog_private/tables/sites/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('catalog_private.sites' AS regclass), 'authenticated', 'UPDATE', NULL, true);