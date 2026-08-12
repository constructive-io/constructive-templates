-- Verify: schemas/catalog_private/tables/bindings/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('catalog_private.bindings' AS regclass), 'authenticated', 'INSERT', NULL, true);