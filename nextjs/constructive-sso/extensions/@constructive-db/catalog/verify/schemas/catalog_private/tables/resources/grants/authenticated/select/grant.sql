-- Verify: schemas/catalog_private/tables/resources/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('catalog_private.resources' AS regclass), 'authenticated', 'SELECT', NULL, true);