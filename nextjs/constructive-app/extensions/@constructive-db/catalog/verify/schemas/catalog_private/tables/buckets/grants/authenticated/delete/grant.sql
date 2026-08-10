-- Verify: schemas/catalog_private/tables/buckets/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('catalog_private.buckets' AS regclass), 'authenticated', 'DELETE', NULL, true);