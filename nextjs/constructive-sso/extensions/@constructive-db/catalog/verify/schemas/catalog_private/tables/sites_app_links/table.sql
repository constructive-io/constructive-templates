-- Verify: schemas/catalog_private/tables/sites_app_links/table


SELECT assert_table(CAST('catalog_private.sites_app_links' AS regclass), false, NULL);