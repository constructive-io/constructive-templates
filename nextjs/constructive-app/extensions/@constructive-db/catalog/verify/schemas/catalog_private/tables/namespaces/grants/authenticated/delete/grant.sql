-- Verify: schemas/catalog_private/tables/namespaces/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('catalog_private.namespaces' AS regclass), 'authenticated', 'DELETE', NULL, true);