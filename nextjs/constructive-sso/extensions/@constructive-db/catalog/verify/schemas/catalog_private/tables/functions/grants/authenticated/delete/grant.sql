-- Verify: schemas/catalog_private/tables/functions/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('catalog_private.functions' AS regclass), 'authenticated', 'DELETE', NULL, true);