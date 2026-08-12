-- Verify: schemas/catalog_private/tables/bindings/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('catalog_private.bindings' AS regclass), 'authenticated', 'DELETE', NULL, true);