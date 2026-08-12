-- Verify: schemas/catalog_private/tables/sites_app_links/indexes/sites_app_links_owner_scope_owner_key_idx


SELECT assert_index(CAST('catalog_private.sites_app_links_owner_scope_owner_key_idx' AS regclass), CAST('catalog_private.sites_app_links' AS regclass), false);