-- Verify: schemas/catalog_private/tables/sites_web_config/table


SELECT assert_table(CAST('catalog_private.sites_web_config' AS regclass), false, NULL);