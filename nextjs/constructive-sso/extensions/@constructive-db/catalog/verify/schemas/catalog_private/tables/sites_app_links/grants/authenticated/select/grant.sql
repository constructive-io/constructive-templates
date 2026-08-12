-- Verify: schemas/catalog_private/tables/sites_app_links/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('catalog_private.sites_app_links' AS regclass), 'authenticated', 'SELECT', NULL, true);