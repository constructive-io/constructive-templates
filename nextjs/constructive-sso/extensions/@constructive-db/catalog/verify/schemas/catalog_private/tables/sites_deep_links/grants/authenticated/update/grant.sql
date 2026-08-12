-- Verify: schemas/catalog_private/tables/sites_deep_links/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('catalog_private.sites_deep_links' AS regclass), 'authenticated', 'UPDATE', NULL, true);