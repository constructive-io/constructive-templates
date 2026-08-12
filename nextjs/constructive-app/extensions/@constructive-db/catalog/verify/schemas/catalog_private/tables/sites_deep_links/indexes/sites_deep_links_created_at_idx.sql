-- Verify: schemas/catalog_private/tables/sites_deep_links/indexes/sites_deep_links_created_at_idx


SELECT assert_index(CAST('catalog_private.sites_deep_links_created_at_idx' AS regclass), CAST('catalog_private.sites_deep_links' AS regclass), false);