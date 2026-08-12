-- Verify: schemas/catalog_private/tables/sites_app_links/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('catalog_private.sites_app_links' AS regclass), 'authenticated', 'INSERT', NULL, true);