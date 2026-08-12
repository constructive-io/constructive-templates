-- Verify: schemas/catalog_private/tables/sites_web_config/indexes/sites_web_config_created_at_idx


SELECT assert_index(CAST('catalog_private.sites_web_config_created_at_idx' AS regclass), CAST('catalog_private.sites_web_config' AS regclass), false);