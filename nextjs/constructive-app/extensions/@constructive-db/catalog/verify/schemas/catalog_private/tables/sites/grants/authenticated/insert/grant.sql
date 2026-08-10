-- Verify: schemas/catalog_private/tables/sites/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('catalog_private.sites' AS regclass), 'authenticated', 'INSERT', NULL, true);