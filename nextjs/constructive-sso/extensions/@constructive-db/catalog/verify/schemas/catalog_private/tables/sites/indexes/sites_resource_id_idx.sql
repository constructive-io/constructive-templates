-- Verify: schemas/catalog_private/tables/sites/indexes/sites_resource_id_idx


SELECT assert_index(CAST('catalog_private.sites_resource_id_idx' AS regclass), CAST('catalog_private.sites' AS regclass), false);