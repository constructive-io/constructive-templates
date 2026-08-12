-- Verify: schemas/catalog_private/tables/domains/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('catalog_private.domains' AS regclass), 'authenticated', 'SELECT', NULL, true);