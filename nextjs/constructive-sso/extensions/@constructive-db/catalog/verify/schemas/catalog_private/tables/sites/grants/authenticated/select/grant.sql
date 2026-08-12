-- Verify: schemas/catalog_private/tables/sites/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('catalog_private.sites' AS regclass), 'authenticated', 'SELECT', NULL, true);