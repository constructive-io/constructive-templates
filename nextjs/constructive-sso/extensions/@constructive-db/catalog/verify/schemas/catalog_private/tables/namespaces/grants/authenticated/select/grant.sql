-- Verify: schemas/catalog_private/tables/namespaces/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('catalog_private.namespaces' AS regclass), 'authenticated', 'SELECT', NULL, true);