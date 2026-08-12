-- Verify: schemas/catalog_private/tables/functions/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('catalog_private.functions' AS regclass), 'authenticated', 'UPDATE', NULL, true);