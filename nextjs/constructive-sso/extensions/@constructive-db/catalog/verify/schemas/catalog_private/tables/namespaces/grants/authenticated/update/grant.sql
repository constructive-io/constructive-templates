-- Verify: schemas/catalog_private/tables/namespaces/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('catalog_private.namespaces' AS regclass), 'authenticated', 'UPDATE', NULL, true);