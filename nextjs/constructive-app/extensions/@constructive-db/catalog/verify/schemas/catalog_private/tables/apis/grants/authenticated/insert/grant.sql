-- Verify: schemas/catalog_private/tables/apis/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('catalog_private.apis' AS regclass), 'authenticated', 'INSERT', NULL, true);