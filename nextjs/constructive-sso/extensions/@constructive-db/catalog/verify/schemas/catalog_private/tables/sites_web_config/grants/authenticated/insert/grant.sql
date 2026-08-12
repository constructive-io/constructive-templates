-- Verify: schemas/catalog_private/tables/sites_web_config/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('catalog_private.sites_web_config' AS regclass), 'authenticated', 'INSERT', NULL, true);