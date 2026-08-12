-- Verify: schemas/catalog_private/tables/apps/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('catalog_private.apps' AS regclass), 'authenticated', 'SELECT', NULL, true);