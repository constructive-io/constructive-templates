-- Verify: schemas/catalog_private/tables/apis/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('catalog_private.apis' AS regclass), 'authenticated', 'UPDATE', NULL, true);