-- Verify: schemas/catalog_private/tables/sites_deep_links/indexes/sites_deep_links_owner_scope_owner_key_idx


SELECT assert_index(CAST('catalog_private.sites_deep_links_owner_scope_owner_key_idx' AS regclass), CAST('catalog_private.sites_deep_links' AS regclass), false);