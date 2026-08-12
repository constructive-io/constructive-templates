-- Verify: schemas/catalog_private/tables/bindings/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('catalog_private.bindings' AS regclass), 'authenticated', 'SELECT', NULL, true);