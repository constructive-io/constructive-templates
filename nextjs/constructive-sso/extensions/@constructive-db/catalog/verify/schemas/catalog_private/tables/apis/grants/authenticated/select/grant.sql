-- Verify: schemas/catalog_private/tables/apis/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('catalog_private.apis' AS regclass), 'authenticated', 'SELECT', NULL, true);