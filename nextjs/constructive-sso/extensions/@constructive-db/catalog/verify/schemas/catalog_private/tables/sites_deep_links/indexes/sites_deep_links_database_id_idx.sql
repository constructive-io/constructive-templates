-- Verify: schemas/catalog_private/tables/sites_deep_links/indexes/sites_deep_links_database_id_idx


SELECT assert_index(CAST('catalog_private.sites_deep_links_database_id_idx' AS regclass), CAST('catalog_private.sites_deep_links' AS regclass), false);