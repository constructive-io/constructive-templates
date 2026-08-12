-- Verify: schemas/catalog_private/tables/apps/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('catalog_private.apps' AS regclass), 'authenticated', 'INSERT', NULL, true);