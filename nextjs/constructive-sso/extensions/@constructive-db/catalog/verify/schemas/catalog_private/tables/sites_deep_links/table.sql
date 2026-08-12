-- Verify: schemas/catalog_private/tables/sites_deep_links/table


SELECT assert_table(CAST('catalog_private.sites_deep_links' AS regclass), false, NULL);