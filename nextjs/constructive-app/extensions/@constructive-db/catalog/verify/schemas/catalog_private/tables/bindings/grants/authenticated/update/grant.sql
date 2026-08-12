-- Verify: schemas/catalog_private/tables/bindings/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('catalog_private.bindings' AS regclass), 'authenticated', 'UPDATE', NULL, true);