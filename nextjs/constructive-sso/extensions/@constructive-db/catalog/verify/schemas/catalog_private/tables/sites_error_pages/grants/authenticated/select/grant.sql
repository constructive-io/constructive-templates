-- Verify: schemas/catalog_private/tables/sites_error_pages/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('catalog_private.sites_error_pages' AS regclass), 'authenticated', 'SELECT', NULL, true);