-- Verify: schemas/catalog_private/tables/sites_web_config/indexes/sites_web_configs_owner_scope_owner_key_idx


SELECT assert_index(CAST('catalog_private.sites_web_configs_owner_scope_owner_key_idx' AS regclass), CAST('catalog_private.sites_web_config' AS regclass), false);