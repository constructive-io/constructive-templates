-- Verify: schemas/catalog_private/tables/namespaces/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('catalog_private.namespaces' AS regclass), 'authenticated', 'INSERT', NULL, true);