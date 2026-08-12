-- Verify: schemas/catalog_private/tables/apis/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('catalog_private.apis' AS regclass), 'authenticated', 'DELETE', NULL, true);