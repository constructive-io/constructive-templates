-- Verify: schemas/catalog_private/tables/resource_installations/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('catalog_private.resource_installations' AS regclass), 'authenticated', 'SELECT', NULL, true);