-- Verify: schemas/catalog_private/tables/functions/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('catalog_private.functions' AS regclass), 'authenticated', 'INSERT', NULL, true);