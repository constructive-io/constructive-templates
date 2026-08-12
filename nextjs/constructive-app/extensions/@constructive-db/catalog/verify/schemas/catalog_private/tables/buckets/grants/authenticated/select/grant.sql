-- Verify: schemas/catalog_private/tables/buckets/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('catalog_private.buckets' AS regclass), 'authenticated', 'SELECT', NULL, true);