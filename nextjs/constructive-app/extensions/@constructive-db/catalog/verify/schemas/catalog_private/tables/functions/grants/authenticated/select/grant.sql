-- Verify: schemas/catalog_private/tables/functions/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('catalog_private.functions' AS regclass), 'authenticated', 'SELECT', NULL, true);