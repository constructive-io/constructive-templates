-- Verify: schemas/catalog_private/tables/sites_app_links/indexes/sites_app_links_site_id_idx


SELECT assert_index(CAST('catalog_private.sites_app_links_site_id_idx' AS regclass), CAST('catalog_private.sites_app_links' AS regclass), false);