-- Verify: schemas/catalog_private/tables/buckets/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('catalog_private.buckets' AS regclass), 'authenticated', 'INSERT', NULL, true);