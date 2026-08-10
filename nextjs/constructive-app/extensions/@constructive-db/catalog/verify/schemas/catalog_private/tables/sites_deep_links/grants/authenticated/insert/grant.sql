-- Verify: schemas/catalog_private/tables/sites_deep_links/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('catalog_private.sites_deep_links' AS regclass), 'authenticated', 'INSERT', NULL, true);